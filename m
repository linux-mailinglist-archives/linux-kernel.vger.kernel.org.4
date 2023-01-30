Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A21A680CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbjA3L5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbjA3L53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:57:29 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA3A1633B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:57:16 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t7so2455876wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XmcsKjHOKYvrUOUyXFN2fyX5681YPhZugfu38EMuB08=;
        b=H2FPuCMk/NF+fT6BAcIMqqiJEBfns65LIpOPsw5l2IRunMicVdx3XMV5/qZ+gvz80o
         c2ym7rtY3PllyRlph6/nAcDVro7vxo5QN37nVetUJ8fnIhYKNcNYT36gON1zlwpkhfKm
         TqyJLZKKFYc9gomPikcHOSM/Fh+IIAhxBYRllJTJ5B9ZarX1C4CLORSnT8Q9qWSyRx+M
         SarrGtpFcNeORELwQaDTH87A9GuMt0YwGJKiBRYhjyZqi0/aPRb9w3/rPvoVSi0AM3td
         qpRwW2J7Xg+vy7C8cVsDH0kwHXosXoncBm0nLFU/oaAdQdioTu2E/pc95qo4vOQ+CITZ
         t+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XmcsKjHOKYvrUOUyXFN2fyX5681YPhZugfu38EMuB08=;
        b=48BbG+eI8u0vrK6QMRBWTDlFyhjHxBRM8vtkIwxK1+vDpJw7bcrgQIeGe2PyVMz9KB
         UX6DQgLwhmR8VhDjZremkKz+hFPtnSryesazxQ6EXZEDsY93j/x/tjsvQG4izdp8iB5d
         IsqaTabqFnkdHRTh7Xa3WLNjagGgpxX+R6btN9ARVX6a40D9YlKefbza8v0bDF17DEBk
         oeNayWpo6NvUUfLsW2bK8Ws+ZTB2I0TtG46fy+YLMnEze2OjJnJJvJeSrVSFzp1kM/j7
         2GDn7zZDJtAmHJYQNRjWOhNmoH1eSgCdhZHU4IwCmaR7sM0N88x87IYHs8nz2OP/tbot
         99Hg==
X-Gm-Message-State: AFqh2krxV1bQoeh9yH+XEEcHbEigIOQ4KrOxL35sVPwnjYZ43vhjey+0
        BHdCb3WKWz02NYGedfE2+PfDFg==
X-Google-Smtp-Source: AMrXdXvY1RmKLr2Gv1YwpANPagILR9MGIr+duSCkotDjClMAoKjRsaSW02r6KnsoxsJY+EfDL1FMlA==
X-Received: by 2002:adf:8bd6:0:b0:2bf:95d0:fa5d with SMTP id w22-20020adf8bd6000000b002bf95d0fa5dmr32299686wra.9.1675079835446;
        Mon, 30 Jan 2023 03:57:15 -0800 (PST)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id m2-20020a056000180200b002bfb5618ee7sm11648461wrh.91.2023.01.30.03.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 03:57:14 -0800 (PST)
Message-ID: <921aa473-b2a6-0905-2b52-1acf84ed399a@baylibre.com>
Date:   Mon, 30 Jan 2023 12:57:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] dt-bindings: memory: mediatek: Add support of
 unmanaged iommu domain
To:     Alexandre Bailon <abailon@baylibre.com>, yong.wu@mediatek.com,
        joro@8bytes.org, will@kernel.org
Cc:     robin.murphy@arm.com, matthias.bgg@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230130102722.133271-1-abailon@baylibre.com>
 <20230130102722.133271-2-abailon@baylibre.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230130102722.133271-2-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 11:27, Alexandre Bailon wrote:
> Currently, the only way to have an unmanaged domain for a device
> is having a dedicated iova region or bank.
> This adds a new bit to MTK_M4U_ID that allows defining devices
> that needs unmanaged iommu domain.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>   include/dt-bindings/memory/mtk-memory-port.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/memory/mtk-memory-port.h b/include/dt-bindings/memory/mtk-memory-port.h
> index 2f68a0511a257..86896c776691a 100644
> --- a/include/dt-bindings/memory/mtk-memory-port.h
> +++ b/include/dt-bindings/memory/mtk-memory-port.h
> @@ -7,11 +7,14 @@
>   #define __DT_BINDINGS_MEMORY_MTK_MEMORY_PORT_H_
>   
>   #define MTK_LARB_NR_MAX			32
> +#define MTK_UNMANAGED_DEVICE            (1 << 31)
>   
>   #define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
>   #define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x1f)
>   #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
> +#define MTK_M4U_UNMANAGED(id)		((id) & MTK_UNMANAGED_DEVICE)
>   
>   #define MTK_IFAIOMMU_PERI_ID(port)	MTK_M4U_ID(0, port)
> +#define MTK_M4U_UNMANAGED_ID(larb, port) (MTK_M4U_ID(larb, port) | MTK_UNMANAGED_DEVICE)
>   
>   #endif

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
