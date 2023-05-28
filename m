Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117F77138A4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 10:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjE1IFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 04:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjE1IFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 04:05:08 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8B9DC
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 01:05:07 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3BObqyyRbSNCw3BObqcWTO; Sun, 28 May 2023 10:05:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685261105;
        bh=Aow8pWzrNqwHcvHDs8g+PZ6GllTfm+wuifMcD2uUgs0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=da7Gaqa1dFgD6ePmQxiIr6dmbG7gWBMdTdTkkmz0rVpOOONkTDVwWz8NLjbsPXQQ8
         yW481GJfWc2sDtrFmldMfluVKqb64LyFtJLIpRTS5mXErMDqu1loIRs4CUKWuJyz0P
         o7Edp3htAEr/fNqQfsAzPhwMPsTAJC+EtOauKpyRj1YpxdM0L37MT2Yzm1DRB5ONT9
         agXfddg7SdjKiPUC447W1SqbON5kuGDZQNQbl7FBnN0lSO8o9v9R8EPfdTV0qe386r
         KckPhYejcCop7RQQnOvFGyL8EdwW8M25Aq7RPsrubiC00H0jTPTkaiYm5PQ1YCXQsR
         oHOU6kIvu7gOA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 May 2023 10:05:05 +0200
X-ME-IP: 86.243.2.178
Message-ID: <1eb0d507-2017-4057-272b-cb3c298fa990@wanadoo.fr>
Date:   Sun, 28 May 2023 10:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/6] ASoC: tas2781: Add tas2781 driver
Content-Language: fr
To:     Shenghao Ding <13916275206@139.com>
Cc:     Ryan_Chu@wistron.com, Sam_Wu@wistron.com,
        alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, gentuser@gmail.com, kevin-lu@ti.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, navada@ti.com, peeyush@ti.com,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        robh+dt@kernel.org, shenghao-ding@ti.com, tiwai@suse.de,
        x1077012@ti.com
References: <20230527223537.9686-1-13916275206@139.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230527223537.9686-1-13916275206@139.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28/05/2023 à 00:35, Shenghao Ding a écrit :
> Create tas2781 driver.
> 
> Signed-off-by: Shenghao Ding <13916275206-7R9yAhoRP9E@public.gmane.org>
> 
> ---
> Changes in v4:
>    - fixed issue| Reported-by: kernel test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>      | Closes: https://lore.kernel.org/oe-kbuild-all/202305192322.gBZ4JIyr-lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org/
>   Changes to be committed:
> 	modified:   sound/soc/codecs/Kconfig
> 	modified:   sound/soc/codecs/Makefile
> 	new file:   sound/soc/codecs/tas2781-comlib.c
> 	new file:   sound/soc/codecs/tas2781-i2c.c
> ---
>   sound/soc/codecs/Kconfig          |  25 +
>   sound/soc/codecs/Makefile         |   6 +
>   sound/soc/codecs/tas2781-comlib.c | 581 +++++++++++++++++++++++
>   sound/soc/codecs/tas2781-i2c.c    | 736 ++++++++++++++++++++++++++++++
>   4 files changed, 1348 insertions(+)
>   create mode 100644 sound/soc/codecs/tas2781-comlib.c
>   create mode 100644 sound/soc/codecs/tas2781-i2c.c

[...]

> +static void tasdev_dsp_prog_blk_remove(struct tasdevice_prog *prog)
> +{
> +	struct tasdevice_data *im;
> +	struct tasdev_blk *blk;
> +	unsigned int nr_blk;

Purely a mater of style, but 'i' is more common, and less verbose.
(same in tasdev_dsp_cfg_blk_remove() below)

> +
> +	if (!prog)
> +		return;
> +
> +	im = &(prog->dev_data);
> +
> +	if (!im->dev_blks)
> +		return;
> +
> +	for (nr_blk = 0; nr_blk < im->nr_blk; nr_blk++) {
> +		blk = &(im->dev_blks[nr_blk]);
> +		kfree(blk->data);
> +	}
> +	kfree(im->dev_blks);
> +}

[...]

> +static int tasdevice_set_profile_id(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_priv = snd_soc_component_get_drvdata(codec);
> +	int ret = 0;
> +
> +	if (tas_priv->rcabin.profile_cfg_id !=
> +		ucontrol->value.integer.value[0]) {
> +		tas_priv->rcabin.profile_cfg_id =
> +			ucontrol->value.integer.value[0];
> +		ret = 0;

So 'ret' is always 0?
Is it what is expected?
If so, removing 'ret' and having return 0; below, looks fine.

Stop reading here. There seems to be a mix-up with patch 4/6.

CJ

