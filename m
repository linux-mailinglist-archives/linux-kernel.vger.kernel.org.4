Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2072F748DCF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjGETag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjGETae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:30:34 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D8910F2;
        Wed,  5 Jul 2023 12:30:33 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-78360f61ba0so334152739f.1;
        Wed, 05 Jul 2023 12:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688585433; x=1691177433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQz3EobltSe+EmcdsuJx0KrcD7z5hVnsG8B8WJoHqG8=;
        b=Lea0CxWJjP62HJomifhlMfekh+Umf6N4viqyRy63LelH/V3C7A4KzNmgerWrgKH2Jz
         n0gvF/6FNj/O0m8x0VAcpuaO0Gh0DP2U7Ftq6WLD00XFZ4F3eNanDNv5cWNs1Hy19aVj
         DU7X9neb04N8J0x7oBGHJop8v6/nDrXVObL7mYhzW+OMS3VWmm2NYm+LkAFUshL+QCi9
         iU4jpcpbDLHO/ZIbdxzqlAn0WRlD+6Z7g6WDN1FQyA/jMlenv+RMJsgjI6Ewedyu03JU
         w8S+7Pt+WR67tKLIMRw7btOYMWU916razLVQlUg1PN0qirrHxKyqunFu+OIZtK7IxNWJ
         H0iQ==
X-Gm-Message-State: ABy/qLbD+NGWpLvgEWD5OcegS1W4RiLPowvr4bKWQOhxC3+fowjzXUaw
        Qx8J3Pu3a86EDHPph5JJiQ==
X-Google-Smtp-Source: APBJJlHXL7CimwQLZrke3i7PIbJu/7Yp22eaIidFcKDP1kX78c3HPd0izvSuIzZNvMpJxliLg+IlUA==
X-Received: by 2002:a5e:a903:0:b0:783:7307:faea with SMTP id c3-20020a5ea903000000b007837307faeamr97528iod.2.1688585433085;
        Wed, 05 Jul 2023 12:30:33 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id ei21-20020a05663829b500b0042b6cb44429sm476699jab.46.2023.07.05.12.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:30:32 -0700 (PDT)
Received: (nullmailer pid 1702388 invoked by uid 1000);
        Wed, 05 Jul 2023 19:30:29 -0000
Date:   Wed, 5 Jul 2023 13:30:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jason-ch Chen <jason-ch.chen@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        jason-ch chen <Jason-ch.Chen@mediatek.com>,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm: Add compatible for MediaTek MT8188
Message-ID: <168858542895.1702303.9157130705256283256.robh@kernel.org>
References: <20230705065744.25848-1-jason-ch.chen@mediatek.com>
 <20230705065744.25848-2-jason-ch.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705065744.25848-2-jason-ch.chen@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Jul 2023 14:57:42 +0800, Jason-ch Chen wrote:
> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
> 
> This commit adds dt-binding documentation for the MediaTek MT8188
> reference board.
> 
> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

