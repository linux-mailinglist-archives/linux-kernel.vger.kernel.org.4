Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD335FF574
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJNVcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJNVcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:32:47 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5F52FC29;
        Fri, 14 Oct 2022 14:32:47 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id s1-20020a4a81c1000000b0047d5e28cdc0so1868746oog.12;
        Fri, 14 Oct 2022 14:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVyH5ppmeLm9SOZr74i6fTL8JuopDsI3RJLzigzFYWI=;
        b=nKLXLUOZJjeIhyQVRDtGs+7AzzL77/GwMQffmpfyeGGH7CK6c84rnfvLmnhDqDYQBy
         r9cLldZ9m3FwnFyf+/HojFXnp6o+VqCgDrB6sQ3zdMthLL0wDovFnrBZVkN39ECnJpA3
         iSQQhPR1XmxH5gIb87Ii+TtwbArH0aRaXzv0/nkBSLX5JvUdoC9WKVt5GIhfJBVl+qyS
         +PuE36vIZBrfPsRWTlRsQ3wXgjY39QJAWTfnSWZmOCa3DcRP20RcrNiTnmY338Ip6Vx7
         ZbIsYEsiknMqKKrOevALp1AVnGIHvJgMKu9V192EJZYUgnqEKZVgiJ0YRd+IsheHQWtX
         eucQ==
X-Gm-Message-State: ACrzQf3SF9PwxVdfsb0djXcqEEut50Db/jiNl+5DA555JVd1l5Rwe24u
        cOEtwQd9QIjXSdcwPOpOwQ==
X-Google-Smtp-Source: AMsMyM48eD18qFAwbjuP2QLLGMmCexEbpR/cfrktU3suYYJfdqfjzaSfN+CXrnhEdtn0X1TNnQBmxQ==
X-Received: by 2002:a05:6820:811:b0:476:6b2:4cd2 with SMTP id bg17-20020a056820081100b0047606b24cd2mr2736553oob.84.1665783166319;
        Fri, 14 Oct 2022 14:32:46 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eo18-20020a056870ec9200b001326b043f37sm1838777oab.36.2022.10.14.14.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:32:45 -0700 (PDT)
Received: (nullmailer pid 2937600 invoked by uid 1000);
        Fri, 14 Oct 2022 21:32:46 -0000
Date:   Fri, 14 Oct 2022 16:32:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvmem: add new stm32mp13 compatible for
 stm32-romem
Message-ID: <166578316635.2937544.10153180806992297540.robh@kernel.org>
References: <20221014172324.1.Ifc1812116ff63f5501f3edd155d3cf5c0ecc846c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014172324.1.Ifc1812116ff63f5501f3edd155d3cf5c0ecc846c@changeid>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 17:23:27 +0200, Patrick Delaunay wrote:
> Add a new compatible for stm32mp13 support.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>  Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
