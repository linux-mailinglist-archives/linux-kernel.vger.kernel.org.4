Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11FC738369
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjFUMNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUMM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:12:59 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E5312C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:12:58 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51be527628fso66294a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687349576; x=1689941576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1S20z+a2meRa1t5ROBbcRF+0qtIDSZlETYaPDTmCWIQ=;
        b=wZf9FY946GCy+xy08dQAUqGP+uauiMOCv/PM7k9BbNqoR3/RkvS3CYXV2s6ZGIkVNR
         FJk1adEklzbuZBMmjE6PpZr8tYp3ywet4DtQCQyMrRsj6PRKEQjmXs9/rd3bnW3wRI1L
         mmjEVtAmGjy16C1OvUNyrmb3zeyTFgJ6CEhOxds/SexZVGmqtujvBi83Pbgs3kPO6ChL
         GAMvTUWJ/QkRXHbz08vg5arB4JoGTecjHD4kJs1zQVIPz3FIYdyNdKg6jmoKlQDk1oc4
         8obTXmXlgcvpR33IhpRjN9oYq3VkZqxHuPPDLbciOPbrLxaYU7HBawBYz9YuqJtMaoUI
         +MYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687349576; x=1689941576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1S20z+a2meRa1t5ROBbcRF+0qtIDSZlETYaPDTmCWIQ=;
        b=A3GwLr3J1fYz/gZMKfwqVRGKJaL7jkCg0B/2GvgW+EOom3XG2aMaLV3WRoH1tsiu2s
         5/p0eU6cu8LbzEVfdgDZ1/1/jtH3kV0uyzGK6oKJPe9b6ZvL+gG/TmUgNgLFgUA9Rqop
         SiwNhPA/tXX78TwIuG/RGZHSNKOem9ACaEVA/1RZ9xF3lxktbYOoe7UxnaDsgakEpwo4
         vKHjrsdE10Bb8W7ZUDCdYZTKXPyZ/W0xVB2W25Ey9Er36+H54aI45tzgPT2RATb8Lu4K
         WWHX4v8giH37QoQ4OB/g9+9MwRSZMcc9SKMzQSpb8bazgK2nE/xhvoY8y3Zsf1sCd7EH
         Zlqg==
X-Gm-Message-State: AC+VfDzBoJKV0SeDp1djlEmJOtcirKYKG/sfbzD+wDRFLtN7Q8kVifcV
        ICIeGLADbFX59NRCXrJaSoKxfg==
X-Google-Smtp-Source: ACHHUZ68VVDiFM83434iVSkRffqR1mrfuPtN7Pi923y2gXxASrxcfPNxrl0l2Ti4w63d8TcW+BemvQ==
X-Received: by 2002:a17:907:d1a:b0:988:e223:9566 with SMTP id gn26-20020a1709070d1a00b00988e2239566mr7643882ejc.62.1687349576599;
        Wed, 21 Jun 2023 05:12:56 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id h6-20020a1709063b4600b009891da61b1asm2911773ejf.44.2023.06.21.05.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 05:12:56 -0700 (PDT)
Message-ID: <7c5acd58-e7b3-097d-329e-15cf4f6bc4d5@baylibre.com>
Date:   Wed, 21 Jun 2023 14:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/4] drm/mediatek: Remove freeing not dynamic allocated
 memory
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230621102247.10116-1-jason-jh.lin@mediatek.com>
 <20230621102247.10116-2-jason-jh.lin@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230621102247.10116-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 12:22, Jason-JH.Lin wrote:
> Fixing the coverity issue of:
> mtk_drm_cmdq_pkt_destroy frees address of mtk_crtc->cmdq_handle
> 
> So remove the free function.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
