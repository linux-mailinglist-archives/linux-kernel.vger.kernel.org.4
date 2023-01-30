Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C07681C88
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjA3VRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjA3VQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:16:55 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5126E302AF;
        Mon, 30 Jan 2023 13:16:53 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id cm26-20020a056830651a00b00684e5c0108dso4917059otb.9;
        Mon, 30 Jan 2023 13:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcrV54BiwPoY9Fj0QzoXljDOtBmNJXprxT9kEPPunIo=;
        b=O+Ey7uuJi+Na7W4G1Wh1XTCnjs5Xb3RZ1zZhmsXc5zQH37O+oCcYJdgoNX6omceSoL
         jWCVBOyZC9L7tqDEI8eDkEwV6G0gdkLyV1KhuDZqm+AAvesOcllHd/VTo7lk0eXtsaqQ
         D3K1tszUIc6+l0HNiMoG62bmzNJtreHkeJFqnoT+jDtUOO2uMEgs/NteksIzHLtquPdO
         a2tXppM5CJs/smeIdyv+sPgIAGTOknTd/iYKmrsouBG3d8e3VAWXU2Noy8cJZSpWFjNi
         S4/dKY9r5YnrLPfzU+kvybE1QUSvU1SYVYUxx3mp+g30qhfy0a6EWr3C+6z8KMtazSAu
         oZLw==
X-Gm-Message-State: AO0yUKWHA6pt9noUd2jucvWWUJ5GtrHqENkQe0YfBOzVUrYKQMIs2CEr
        YSj+cOHCv9UWyviZMD0OrA==
X-Google-Smtp-Source: AK7set9mpHIxfS1q1mfC7od0uezdqQ4nZnOQEwXW6chL10CHt094V/in9eOzZc7rXGaQD+kKcqsv2Q==
X-Received: by 2002:a9d:4d87:0:b0:684:dbfd:f239 with SMTP id u7-20020a9d4d87000000b00684dbfdf239mr5080904otk.9.1675113412412;
        Mon, 30 Jan 2023 13:16:52 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q1-20020a9d5781000000b0068bd922a244sm865309oth.20.2023.01.30.13.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:16:52 -0800 (PST)
Received: (nullmailer pid 3454207 invoked by uid 1000);
        Mon, 30 Jan 2023 21:16:51 -0000
Date:   Mon, 30 Jan 2023 15:16:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] dt-bindings: input: touchscreen: st,stmfts: convert to
 dtschema
Message-ID: <167511341075.3454008.8039440710554703660.robh@kernel.org>
References: <20230127202040.196411-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127202040.196411-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 27 Jan 2023 21:20:40 +0100, Krzysztof Kozlowski wrote:
> Convert the ST-Microelectronics FingerTip touchscreen controller
> bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/input/touchscreen/st,stmfts.txt  | 41 -----------
>  .../bindings/input/touchscreen/st,stmfts.yaml | 72 +++++++++++++++++++
>  2 files changed, 72 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
