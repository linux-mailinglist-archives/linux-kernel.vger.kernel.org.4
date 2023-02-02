Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EC56883ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjBBQR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjBBQRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:17:24 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEDE6CCA7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:17:23 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k16so1826987wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tM2tAG1KHS9gAyhcPLjkjYt8F4gMNaekAqdi+Z0D3jE=;
        b=QskZxot5mc2Exa8IWCLZzUy0ZgCN5SeK2vwVanKyB2t7of02G81jkeeZ/2Bzj7lfmm
         2siEjAcnKKBmmU+NNSxvq35ExnO+IKq1JiytOwRetZunBwuOXuBdHP+v2T/0QnfArYxL
         b4uRxVGr3Ta5mfPQ3az1H8E3HzVuK9SnsMsq9ArYDnmFyrX3bfmJENN9M0tnBt1pSnqd
         KaatnXYDhoUurnrXaq6szgyFW7CZenyM/A3vZ/1qqoas2SUy0uAdyewjiBH/VCzBAzOt
         h4OrQA/KW8RrhdN0a1as7vg4+4gFdK4ql0TK7adPFUlZY/cGovr5c4V1yUZ76c48blqk
         zhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tM2tAG1KHS9gAyhcPLjkjYt8F4gMNaekAqdi+Z0D3jE=;
        b=T915mE1DQymxZeltt4j5Plp2jzkQHQZuY6cCNdAO/RU0URdjSYpRhnVK1028THoARV
         h4AZC9BHwH695vENJggtRRr1cGTQMNaOE+rg76mtq8I0E37Oi+5oYWCHI0EfqvCF30Pi
         og96i8zKjVZN4lCbN2uTast8XkqJyQOCarbVh2XjOUZCZZhTogHkcCw1JAts6+KpwuGw
         QZJH3ldwm0olxqKmpC7E3H/Ib2mOQTJh3ADNW353Vdv9YBho+7Cc1wwHUokSm+p7mTUF
         kl4nv5psbwQfDKpJySIDCK0mlIEhOUh5XsSlV+6jz+0Qg4ZZF0LnFO52FURTB5APxLWk
         iPvg==
X-Gm-Message-State: AO0yUKWq0Q6i7yqx3/MrP0rQA65pHwKf/7qbOvJBz8Zroc+l9JpEGIzl
        v2Ih1Xc0Wv0vd5xe/9+tMEU=
X-Google-Smtp-Source: AK7set+px4qLsaBOaUEfLm/zCt9ycrIHjHt1QgT6ErzvraazA3Tx2vnHVt3VDBi6Er2VVCrDXjc4dw==
X-Received: by 2002:a05:600c:3d06:b0:3df:dc0d:f0b3 with SMTP id bh6-20020a05600c3d0600b003dfdc0df0b3mr2521516wmb.9.1675354641972;
        Thu, 02 Feb 2023 08:17:21 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b003dee8c5d814sm5332469wmo.24.2023.02.02.08.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:17:21 -0800 (PST)
Date:   Thu, 2 Feb 2023 15:17:04 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
        perex@perex.cz, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: mediatek: mt8188: remove etdm dead code
Message-ID: <Y9upwNAzXzSxmiFo@kadam>
References: <20230202103704.15626-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202103704.15626-1-trevor.wu@mediatek.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 06:37:04PM +0800, Trevor Wu wrote:
> Some Smatch static checker warning like below was found.
> 
> sound/soc/mediatek/mt8188/mt8188-dai-etdm.c:2487
> mt8188_dai_etdm_parse_of()
> warn: 'ret' returned from snprintf() might be larger than 48
> 
>     2479         for (i = 0; i < MT8188_AFE_IO_ETDM_NUM; i++) {
>     2480                 dai_id = ETDM_TO_DAI_ID(i);
>     2481                 etdm_data = afe_priv->dai_priv[dai_id];
>     2482
>     2483                 ret = snprintf(prop, sizeof(prop),
>     2484                                "mediatek,%s-multi-pin-mode",
>     2485                                of_afe_etdms[i].name);
>     2486                 if (ret < 0) {
> --> 2487                         dev_err(afe->dev, "%s snprintf
> err=%d\n",
>     2488
> 
> In linux kernel, snprintf() never returns negatives. On the other hand,
> the format string like "mediatek,%s-multi-pin-mode" must be smaller
> than sizeof(prop)=48.
> 
> After discussing in the mail thread[1], I remove the dead code to fix
> the Smatch warnings.
> 
> [1]: https://lore.kernel.org/all/Y9EdBg641tJDDrt%2F@kili/
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---

Thanks!

Regards,
dan carpenter

