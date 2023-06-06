Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D9A7237D1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjFFGgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbjFFGgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:36:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64CBE4F;
        Mon,  5 Jun 2023 23:36:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f623adec61so58436215e9.0;
        Mon, 05 Jun 2023 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686033390; x=1688625390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhedNjKaUYCOISv5l7y5mTBG4Uqpt0ieEYUYH3C4nxM=;
        b=inlRyYHOgqER7/6mkM2P3HRNBWYTsH/FZLBSQZe8NEwjfWGCH0Nhv2DTN6F5J9QSCb
         OCAiRKdqNIGgq571OE1I1Bk05FijT8SuOtQ9NgvEiAGtorDh/8ipQcRAfU3fBye5shVq
         nPwSz8QLndjpZ9doPWzUreKLb7hrUW2QCyPqbPcTuMPT7C6+zPQQcIsi1/3fpj9v53js
         kSO7PrPs0IUzQBDQffFqeoSibxNdmEjQXJLJluBD1TpsMvLbHpAHWNYJZW+FXJhC7J4R
         CGDx6Z7eWpgBvNx5i2Qa+WiufRbjrKDGkeIc3WbuiFXUjeWSlmxutcywzfloMDaWqPvl
         NP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686033390; x=1688625390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhedNjKaUYCOISv5l7y5mTBG4Uqpt0ieEYUYH3C4nxM=;
        b=N/dCUlqekijgfcpeBb8JgErIQiFHH75ypnulscHHmK3riklsDJUCOL0Me+4qLhaKSA
         IgK+M3IaNEvGRcnBxm+MkuK1MVwroB3o1ePNWfGizUhbP4KgWSTt2slt+3/MjiSy6GsW
         DpqppQwz20D2+zurI7Mge1c73EDHxhrZ8W+SxUc5HdK30X5RTLcMImOkmblIuGO1C8mJ
         KBIzFucbNro5HrDQmPAbKf75SowdHMKedLbp42JxmZpwUOwgqvs1kvQ1OWprwh3NRoAE
         tP5xpa9cg/n1ub5xDN81Scy/tSlMPVEwOzzC8jt/lesQmn8WfW1OS226BXdlvD7OERtB
         MP4g==
X-Gm-Message-State: AC+VfDymn8Cnq/VY4IdnMkklN93R8Zt/RzkCaBTwskmGKxS2n5vi53Ls
        Tmrq10wGJYLWMqCKnMGJdQ2UqXHf2rOxqw==
X-Google-Smtp-Source: ACHHUZ6KDOKkGJYFqnUJ0Ko4djdiSkTL4HS2X7cqcJInsUa0swdQmwHqZNgDMx0TcFJRtXRnu6hgxw==
X-Received: by 2002:a7b:c7d4:0:b0:3f7:28d8:4319 with SMTP id z20-20020a7bc7d4000000b003f728d84319mr1139286wmk.1.1686033389862;
        Mon, 05 Jun 2023 23:36:29 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id d17-20020a056000115100b0030af15d7e41sm11739773wrx.4.2023.06.05.23.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:36:28 -0700 (PDT)
Message-ID: <fe360de7-54d8-6351-3df8-e865d5a0a08b@gmail.com>
Date:   Tue, 6 Jun 2023 08:36:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/6] media: dt-bindings: mediatek,vcodec: Don't require
 assigned-clocks
Content-Language: en-US, ca-ES, es-ES
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230605162030.274395-1-nfraprado@collabora.com>
 <20230605162030.274395-3-nfraprado@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230605162030.274395-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/2023 18:20, Nícolas F. R. A. Prado wrote:
> On MT8183 it's not necessary to configure the parent for the clocks.
> Remove the assigned-clocks and assigned-clock-parents from the required
> list.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> 
>   .../devicetree/bindings/media/mediatek,vcodec-decoder.yaml      | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> index 57d5ca776df0..6447e6c86f29 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> @@ -67,8 +67,6 @@ required:
>     - clocks
>     - clock-names
>     - iommus
> -  - assigned-clocks
> -  - assigned-clock-parents
>   
>   allOf:
>     - if:
