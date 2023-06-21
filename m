Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFD07383F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjFUMiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjFUMiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:38:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B090C9B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:38:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98cd280cf94so67754366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687351129; x=1689943129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FhbZVLRFRJkTRcxEmprI7xfESOe65znA2x7PCSJbP4w=;
        b=rX6xit08xL8hzTukILjewPEnGxlcYO5HBbI47Bw7rqKA5AjR4jFyG1ELr57YKg4TRz
         n1QiHHs9fPIIsKIh7k/GVzXx4RnRidzckIQ8HTZZRsqkQmJJ0azsD+REJSPEvrpOcyjg
         Jze9UkEE5qaaePRw1ySE8RojnxoU3ThJh9dxwScMAWiNDoKlvNY0VbJPetGTVDOFj7I/
         g7lsANh+TFP15DcIptX4lyDA3rSZ+FZxBCISG359k+R2tD/Ha6Zj9gSeN1KjwEP8oG95
         FzDCX5oBJ5DkhXOL1j0aMFp6dGspob1mBzUxvhVD6o4tg+C7GBlcUKKtyXgqaeViifxM
         ZVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687351129; x=1689943129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhbZVLRFRJkTRcxEmprI7xfESOe65znA2x7PCSJbP4w=;
        b=MaQliH8VcQxwVlbeK1nZPHoqvhAzcasrool9TjP/ECZS72Ao+zbzUZHgNcx/47h8eE
         cpgU2QwPUksJU+lCkSbMgJdPH5Fcv2VKnXG/ugrpjw6lzvpBsbfyN/E4YMT2s0pK2Dpn
         /mYfbnfwPV7cUPMSd3Ygbp7IPkW0eTPWl6OBsvAY48DeJdDxkxctqcSRr3/Sfz1Gfcnw
         HC11lqPZ/omZb357IyECAU9HBxALes+RvVSb2Qa5UWqPIkL0L/rFmYTM60OIjmv/HaQ1
         nsGyNCn5eEF/V2ItIRS7iIaVBwiYS2BG16Fe7jNhsyka8R/OxhhuOyVFrG53KWZp+pU7
         iAgw==
X-Gm-Message-State: AC+VfDx3BcrQkRLdL+q9CbKH1PThQYW9KBVYyTISYz6b7QfwbwmtUzqI
        51Q6mucxa8Z1AA+BVKtuapPdIA==
X-Google-Smtp-Source: ACHHUZ6BSMtfKwz5HW9GJYvd/KsZG+lavipJGEgd/TdkOKxDDjdlZQP0gQsDk+qCv1GjAFRUQENgow==
X-Received: by 2002:a17:907:6292:b0:983:ba44:48af with SMTP id nd18-20020a170907629200b00983ba4448afmr14707480ejc.53.1687351129098;
        Wed, 21 Jun 2023 05:38:49 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906279800b00986d8722e46sm3145497ejc.17.2023.06.21.05.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 05:38:48 -0700 (PDT)
Message-ID: <a2adfff3-1fc5-b3ab-c4a8-df06dbf5bb17@baylibre.com>
Date:   Wed, 21 Jun 2023 14:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 4/4] drm/mediatek: Fix dereference before null check
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
 <20230621102247.10116-5-jason-jh.lin@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230621102247.10116-5-jason-jh.lin@mediatek.com>
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
> Null-checking state suggests that it may be null, but it has already
> been dereferenced on drm_atomic_get_new_plane_state(state, plane).
> 
> The parameter state will never be NULL currently, so just remove the
> state is NULL flow in this function.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
