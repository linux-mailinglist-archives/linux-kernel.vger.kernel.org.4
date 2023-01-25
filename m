Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ACE67B5CD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbjAYPWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbjAYPWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:22:17 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB58126583;
        Wed, 25 Jan 2023 07:22:14 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso1455429wmn.5;
        Wed, 25 Jan 2023 07:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+cKkovPwhRMpRzyfESa0Nn+hlo0AHN0pmurSQImGzGg=;
        b=c56bBLOwNUcAjFdOKoGKTZgg8PImKyx+ee/GIya27ZazszZv/4X8DalRcCiTxuVUbf
         0ay7SIKVdx2CfL8p9KMsDDu5uOTzkxFFqd0RuN6Y92X/nWdeGw8i6C/I6bt8VSY2633G
         Mph8tDz988vKVnezUAHA392AngkNnwyAhIKf5il884nlCMRr9R3fE3v6/h5ow4qdgj+M
         Fq22FUCrXId6aRexAUOKNAidm7ygLajXRo0MQQvqCwCvcafsYv13aFntghvqRWq0lduO
         BshGHnVksmh+ctYu3DLo531bxv0+iU5Sbwo6+yl52W160RZ6BEO+K3ik/SxmuwBctvgF
         c8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cKkovPwhRMpRzyfESa0Nn+hlo0AHN0pmurSQImGzGg=;
        b=cQ80CS58FeN9lJBPf9PFNyVcWpqD5Ig04NBglBSolFII4yN3xkOFCT7Ys6/R8eL/jj
         c8DBLVyFjgNFhR2VWw7ua/ZfEhrtCY7Ck1+QAJzTr0tV0CgB8sT3s86UEcQVy3aIyiIv
         RDlhvQxqXbiLYzZvI3d+AyL/sPKNfndXWeVgEAoeSyws/k90aIj1YA4tzO5+8SzuU3TN
         v64W2uGca9jgJ615/v86HWrn7VjFCkXLBxiCHAytifj4P8ijHykfIhAeHq/GdXzA9Mif
         ubBITIdw5pVtwJMFdSTZks0/5qHeBJahpCR2KTbdFjFE69rzRMsh079X2C+ufSBmAg19
         DFng==
X-Gm-Message-State: AFqh2kqjyXF+ijfA2sUcK9NbP53sy6SObeQ2MXwLhHaCYsvny7kFVZ/j
        lxXTlc2bAY+D+7v8ypJTG48=
X-Google-Smtp-Source: AMrXdXte+pCfs4LGfK4VbuM26cJk1PIH0LuEe4MZdQEOXF06DWuRk4ApCwbryG5b3dH0tXKAc/PKCQ==
X-Received: by 2002:a05:600c:2d0b:b0:3da:fcf0:a31d with SMTP id x11-20020a05600c2d0b00b003dafcf0a31dmr32278071wmf.22.1674660133088;
        Wed, 25 Jan 2023 07:22:13 -0800 (PST)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c130f00b003db0659c454sm2432709wmf.32.2023.01.25.07.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 07:22:12 -0800 (PST)
Message-ID: <892229a2-01b9-f4cc-95fb-980107166715@gmail.com>
Date:   Wed, 25 Jan 2023 16:22:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [V1,0/2] Add jpeg enc & dec device node for MT8195
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, kyrie wu <kyrie.wu@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com
References: <20230112084503.4277-1-irui.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230112084503.4277-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thanks!

On 12/01/2023 09:45, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> This series add jpeg enc and dec device node to dts file
> for the purpose of supporting multi hardwares jpeg
> enc & dec of MT8195.
> 
> This series has been tested with MT8195 Gstreamer.
> Encoding and decoding worked for this chip.
> 
> Patches 1 Adds jpeg encoder device node for mt8195.
> 
> Patches 2 Adds jpeg decoder device node for mt8195.
> 
> kyrie wu (2):
>    arm64: dts: mt8195: add jpeg encode device node
>    arm64: dts: mt8195: add jpeg decode device node
> 
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 100 +++++++++++++++++++++++
>   1 file changed, 100 insertions(+)
> 
