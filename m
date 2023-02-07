Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E188E68D3AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjBGKJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjBGKJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:09:17 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7B3B45F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:08:52 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n13so10631098wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uBjwL3X2HhfSsi8GSFH1CrM9+dq4wni12QE/75bmps=;
        b=Mbeh36rfjqSD/9tb2T97Hk6RyZlM2o7NAAZinKXXhss8GTupnJAV1Il2bvU0cfM6bk
         OZeBFGXB8KRCwjCqBGVt08j3E68phG0/AHrZbFacvv6R+OAyAtMWp9D1AUmoKkF6dGsg
         AUlgDXlKPW6Xd81aK48m3BtQdhoM6oDjNhRIvotdUXgQnKOqCxzo2vl1T+ScQzYCp1kq
         q6LfdK+7ZzFwgq7HKCNAxcKo1hWzdK9Ci5Fd2Z4a/Gna19R3zuojYRuOYqnpwV/QtSHz
         be7cJOzEpk4nHqMZoJandUhkti3+BT0CUolzconzvt5Abqe7tjLBUsCYARF5QfD3Ev5P
         ZKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uBjwL3X2HhfSsi8GSFH1CrM9+dq4wni12QE/75bmps=;
        b=31r6XCx7jgN6O7Ge0IWqY2lp3YqythLP2qxhn+cHmp4z6/f4WJBdge0BFqWTLOdVgt
         sfqaBEIjZQGtGtzZwJTHTlx5JZA0LDEvT2vY21yieEcBWBiUu7V+mHlyK8eJu53kjCsP
         yQSUanDwuKQ7BPsj81Ew7jFvEgfu/rVEPp2vnwkPds/PfGOSlIs2FNrP8Z+klNsw22w9
         2qYmcAb/K8F/ExEgdtTc53gOqzfqCuQeMoPkvl7OrHnxgRLjVrXFkcnVgoJAkCBqfmLd
         0e7prltaegKCz/NxllmBguCkdXOdU/vagrcPT5F4D3/pkDNfm5cw4s2e4dXsfN275wJ0
         O+pQ==
X-Gm-Message-State: AO0yUKUBnTZ9rfxsNUHM4yqWrUCundiIZ2IlAac0QNHRRskFfDDLzGWe
        mWpbrXmEedx5izpckyYeNFo=
X-Google-Smtp-Source: AK7set93uxF3lHRrPiRHQM1UH+2x36Mh43Pw4XoyelOnuMdSq0hgbz6HUWI6ZkHYokasTZVsisscqQ==
X-Received: by 2002:a05:600c:4d16:b0:3df:e549:bd00 with SMTP id u22-20020a05600c4d1600b003dfe549bd00mr2477864wmp.1.1675764528790;
        Tue, 07 Feb 2023 02:08:48 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k19-20020a05600c1c9300b003dc43a10fa5sm14354269wms.13.2023.02.07.02.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 02:08:48 -0800 (PST)
Date:   Tue, 7 Feb 2023 13:08:45 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: sound/soc/soc-topology.c:1405 soc_tplg_dapm_widget_create() warn:
 missing error code 'ret'
Message-ID: <202302071823.2veEqSHM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amadeusz,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   05ecb680708a1dbe6554d6fc17e5d9a8a7cb5e6a
commit: 47a1886a610aca6a55c18ee677f9176e73162e97 ASoC: Intel: avs: Enable AVS driver only on x86 platforms
config: microblaze-randconfig-m041-20230206 (https://download.01.org/0day-ci/archive/20230207/202302071823.2veEqSHM-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
sound/soc/soc-topology.c:1405 soc_tplg_dapm_widget_create() warn: missing error code 'ret'

vim +/ret +1405 sound/soc/soc-topology.c

8a9782346dccd8 Liam Girdwood        2015-05-29  1342  static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
8a9782346dccd8 Liam Girdwood        2015-05-29  1343  	struct snd_soc_tplg_dapm_widget *w)
8a9782346dccd8 Liam Girdwood        2015-05-29  1344  {
8a9782346dccd8 Liam Girdwood        2015-05-29  1345  	struct snd_soc_dapm_context *dapm = &tplg->comp->dapm;
8a9782346dccd8 Liam Girdwood        2015-05-29  1346  	struct snd_soc_dapm_widget template, *widget;
8a9782346dccd8 Liam Girdwood        2015-05-29  1347  	struct snd_soc_tplg_ctl_hdr *control_hdr;
8a9782346dccd8 Liam Girdwood        2015-05-29  1348  	struct snd_soc_card *card = tplg->comp->card;
b9c035aa43b8c0 Jaska Uimonen        2021-05-19  1349  	unsigned int *kcontrol_type = NULL;
d29d41e28eea65 Jaska Uimonen        2021-05-07  1350  	struct snd_kcontrol_new *kc;
d29d41e28eea65 Jaska Uimonen        2021-05-07  1351  	int mixer_count = 0;
d29d41e28eea65 Jaska Uimonen        2021-05-07  1352  	int bytes_count = 0;
d29d41e28eea65 Jaska Uimonen        2021-05-07  1353  	int enum_count = 0;
8a9782346dccd8 Liam Girdwood        2015-05-29  1354  	int ret = 0;
d29d41e28eea65 Jaska Uimonen        2021-05-07  1355  	int i;
8a9782346dccd8 Liam Girdwood        2015-05-29  1356  
8a9782346dccd8 Liam Girdwood        2015-05-29  1357  	if (strnlen(w->name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
8a9782346dccd8 Liam Girdwood        2015-05-29  1358  		SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
8a9782346dccd8 Liam Girdwood        2015-05-29  1359  		return -EINVAL;
8a9782346dccd8 Liam Girdwood        2015-05-29  1360  	if (strnlen(w->sname, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
8a9782346dccd8 Liam Girdwood        2015-05-29  1361  		SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
8a9782346dccd8 Liam Girdwood        2015-05-29  1362  		return -EINVAL;
8a9782346dccd8 Liam Girdwood        2015-05-29  1363  
8a9782346dccd8 Liam Girdwood        2015-05-29  1364  	dev_dbg(tplg->dev, "ASoC: creating DAPM widget %s id %d\n",
8a9782346dccd8 Liam Girdwood        2015-05-29  1365  		w->name, w->id);
8a9782346dccd8 Liam Girdwood        2015-05-29  1366  
8a9782346dccd8 Liam Girdwood        2015-05-29  1367  	memset(&template, 0, sizeof(template));
8a9782346dccd8 Liam Girdwood        2015-05-29  1368  
8a9782346dccd8 Liam Girdwood        2015-05-29  1369  	/* map user to kernel widget ID */
5aebe7c7f9c20e Pierre-Louis Bossart 2019-04-04  1370  	template.id = get_widget_id(le32_to_cpu(w->id));
752c938a5c14b8 Dan Carpenter        2019-09-25  1371  	if ((int)template.id < 0)
8a9782346dccd8 Liam Girdwood        2015-05-29  1372  		return template.id;
8a9782346dccd8 Liam Girdwood        2015-05-29  1373  
c3421a6a65abc6 Liam Girdwood        2017-06-06  1374  	/* strings are allocated here, but used and freed by the widget */
8a9782346dccd8 Liam Girdwood        2015-05-29  1375  	template.name = kstrdup(w->name, GFP_KERNEL);
8a9782346dccd8 Liam Girdwood        2015-05-29  1376  	if (!template.name)
8a9782346dccd8 Liam Girdwood        2015-05-29  1377  		return -ENOMEM;
8a9782346dccd8 Liam Girdwood        2015-05-29  1378  	template.sname = kstrdup(w->sname, GFP_KERNEL);
8a9782346dccd8 Liam Girdwood        2015-05-29  1379  	if (!template.sname) {
8a9782346dccd8 Liam Girdwood        2015-05-29  1380  		ret = -ENOMEM;
8a9782346dccd8 Liam Girdwood        2015-05-29  1381  		goto err;
8a9782346dccd8 Liam Girdwood        2015-05-29  1382  	}
5aebe7c7f9c20e Pierre-Louis Bossart 2019-04-04  1383  	template.reg = le32_to_cpu(w->reg);
5aebe7c7f9c20e Pierre-Louis Bossart 2019-04-04  1384  	template.shift = le32_to_cpu(w->shift);
5aebe7c7f9c20e Pierre-Louis Bossart 2019-04-04  1385  	template.mask = le32_to_cpu(w->mask);
5aebe7c7f9c20e Pierre-Louis Bossart 2019-04-04  1386  	template.subseq = le32_to_cpu(w->subseq);
8a9782346dccd8 Liam Girdwood        2015-05-29  1387  	template.on_val = w->invert ? 0 : 1;
8a9782346dccd8 Liam Girdwood        2015-05-29  1388  	template.off_val = w->invert ? 1 : 0;
5aebe7c7f9c20e Pierre-Louis Bossart 2019-04-04  1389  	template.ignore_suspend = le32_to_cpu(w->ignore_suspend);
5aebe7c7f9c20e Pierre-Louis Bossart 2019-04-04  1390  	template.event_flags = le16_to_cpu(w->event_flags);
8a9782346dccd8 Liam Girdwood        2015-05-29  1391  	template.dobj.index = tplg->index;
8a9782346dccd8 Liam Girdwood        2015-05-29  1392  
8a9782346dccd8 Liam Girdwood        2015-05-29  1393  	tplg->pos +=
5aebe7c7f9c20e Pierre-Louis Bossart 2019-04-04  1394  		(sizeof(struct snd_soc_tplg_dapm_widget) +
5aebe7c7f9c20e Pierre-Louis Bossart 2019-04-04  1395  		 le32_to_cpu(w->priv.size));
5aebe7c7f9c20e Pierre-Louis Bossart 2019-04-04  1396  
8a9782346dccd8 Liam Girdwood        2015-05-29  1397  	if (w->num_kcontrols == 0) {
8a9782346dccd8 Liam Girdwood        2015-05-29  1398  		template.num_kcontrols = 0;
8a9782346dccd8 Liam Girdwood        2015-05-29  1399  		goto widget;
8a9782346dccd8 Liam Girdwood        2015-05-29  1400  	}
8a9782346dccd8 Liam Girdwood        2015-05-29  1401  
d29d41e28eea65 Jaska Uimonen        2021-05-07  1402  	template.num_kcontrols = le32_to_cpu(w->num_kcontrols);
d29d41e28eea65 Jaska Uimonen        2021-05-07  1403  	kc = devm_kcalloc(tplg->dev, le32_to_cpu(w->num_kcontrols), sizeof(*kc), GFP_KERNEL);
d29d41e28eea65 Jaska Uimonen        2021-05-07  1404  	if (!kc)
9c363532413cda Peter Ujfalusi       2022-03-31 @1405  		goto hdr_err;

ret = -ENOMEM;

d29d41e28eea65 Jaska Uimonen        2021-05-07  1406  
d29d41e28eea65 Jaska Uimonen        2021-05-07  1407  	kcontrol_type = devm_kcalloc(tplg->dev, le32_to_cpu(w->num_kcontrols), sizeof(unsigned int),
d29d41e28eea65 Jaska Uimonen        2021-05-07  1408  				     GFP_KERNEL);
d29d41e28eea65 Jaska Uimonen        2021-05-07  1409  	if (!kcontrol_type)
9c363532413cda Peter Ujfalusi       2022-03-31  1410  		goto hdr_err;

Same.

d29d41e28eea65 Jaska Uimonen        2021-05-07  1411  
1baad7dad115ea Pierre-Louis Bossart 2021-10-25  1412  	for (i = 0; i < le32_to_cpu(w->num_kcontrols); i++) {
d29d41e28eea65 Jaska Uimonen        2021-05-07  1413  		control_hdr = (struct snd_soc_tplg_ctl_hdr *)tplg->pos;
5aebe7c7f9c20e Pierre-Louis Bossart 2019-04-04  1414  		switch (le32_to_cpu(control_hdr->ops.info)) {
8a9782346dccd8 Liam Girdwood        2015-05-29  1415  		case SND_SOC_TPLG_CTL_VOLSW:
8a9782346dccd8 Liam Girdwood        2015-05-29  1416  		case SND_SOC_TPLG_CTL_STROBE:
8a9782346dccd8 Liam Girdwood        2015-05-29  1417  		case SND_SOC_TPLG_CTL_VOLSW_SX:
8a9782346dccd8 Liam Girdwood        2015-05-29  1418  		case SND_SOC_TPLG_CTL_VOLSW_XR_SX:
8a9782346dccd8 Liam Girdwood        2015-05-29  1419  		case SND_SOC_TPLG_CTL_RANGE:
8a9782346dccd8 Liam Girdwood        2015-05-29  1420  		case SND_SOC_TPLG_DAPM_CTL_VOLSW:
d29d41e28eea65 Jaska Uimonen        2021-05-07  1421  			/* volume mixer */
d29d41e28eea65 Jaska Uimonen        2021-05-07  1422  			kc[i].index = mixer_count;
d29d41e28eea65 Jaska Uimonen        2021-05-07  1423  			kcontrol_type[i] = SND_SOC_TPLG_TYPE_MIXER;
d29d41e28eea65 Jaska Uimonen        2021-05-07  1424  			mixer_count++;
d29d41e28eea65 Jaska Uimonen        2021-05-07  1425  			ret = soc_tplg_dapm_widget_dmixer_create(tplg, &kc[i]);
d29d41e28eea65 Jaska Uimonen        2021-05-07  1426  			if (ret < 0)
8a9782346dccd8 Liam Girdwood        2015-05-29  1427  				goto hdr_err;
8a9782346dccd8 Liam Girdwood        2015-05-29  1428  			break;
8a9782346dccd8 Liam Girdwood        2015-05-29  1429  		case SND_SOC_TPLG_CTL_ENUM:
8a9782346dccd8 Liam Girdwood        2015-05-29  1430  		case SND_SOC_TPLG_CTL_ENUM_VALUE:
8a9782346dccd8 Liam Girdwood        2015-05-29  1431  		case SND_SOC_TPLG_DAPM_CTL_ENUM_DOUBLE:
8a9782346dccd8 Liam Girdwood        2015-05-29  1432  		case SND_SOC_TPLG_DAPM_CTL_ENUM_VIRT:
8a9782346dccd8 Liam Girdwood        2015-05-29  1433  		case SND_SOC_TPLG_DAPM_CTL_ENUM_VALUE:
d29d41e28eea65 Jaska Uimonen        2021-05-07  1434  			/* enumerated mixer */
d29d41e28eea65 Jaska Uimonen        2021-05-07  1435  			kc[i].index = enum_count;
d29d41e28eea65 Jaska Uimonen        2021-05-07  1436  			kcontrol_type[i] = SND_SOC_TPLG_TYPE_ENUM;
d29d41e28eea65 Jaska Uimonen        2021-05-07  1437  			enum_count++;
d29d41e28eea65 Jaska Uimonen        2021-05-07  1438  			ret = soc_tplg_dapm_widget_denum_create(tplg, &kc[i]);
d29d41e28eea65 Jaska Uimonen        2021-05-07  1439  			if (ret < 0)
8a9782346dccd8 Liam Girdwood        2015-05-29  1440  				goto hdr_err;
8a9782346dccd8 Liam Girdwood        2015-05-29  1441  			break;
8a9782346dccd8 Liam Girdwood        2015-05-29  1442  		case SND_SOC_TPLG_CTL_BYTES:
d29d41e28eea65 Jaska Uimonen        2021-05-07  1443  			/* bytes control */
d29d41e28eea65 Jaska Uimonen        2021-05-07  1444  			kc[i].index = bytes_count;
d29d41e28eea65 Jaska Uimonen        2021-05-07  1445  			kcontrol_type[i] = SND_SOC_TPLG_TYPE_BYTES;
d29d41e28eea65 Jaska Uimonen        2021-05-07  1446  			bytes_count++;
d29d41e28eea65 Jaska Uimonen        2021-05-07  1447  			ret = soc_tplg_dapm_widget_dbytes_create(tplg, &kc[i]);
d29d41e28eea65 Jaska Uimonen        2021-05-07  1448  			if (ret < 0)
8a9782346dccd8 Liam Girdwood        2015-05-29  1449  				goto hdr_err;
8a9782346dccd8 Liam Girdwood        2015-05-29  1450  			break;
8a9782346dccd8 Liam Girdwood        2015-05-29  1451  		default:
8a9782346dccd8 Liam Girdwood        2015-05-29  1452  			dev_err(tplg->dev, "ASoC: invalid widget control type %d:%d:%d\n",
8a9782346dccd8 Liam Girdwood        2015-05-29  1453  				control_hdr->ops.get, control_hdr->ops.put,
5aebe7c7f9c20e Pierre-Louis Bossart 2019-04-04  1454  				le32_to_cpu(control_hdr->ops.info));
8a9782346dccd8 Liam Girdwood        2015-05-29  1455  			ret = -EINVAL;
8a9782346dccd8 Liam Girdwood        2015-05-29  1456  			goto hdr_err;
8a9782346dccd8 Liam Girdwood        2015-05-29  1457  		}
d29d41e28eea65 Jaska Uimonen        2021-05-07  1458  	}
d29d41e28eea65 Jaska Uimonen        2021-05-07  1459  
d29d41e28eea65 Jaska Uimonen        2021-05-07  1460  	template.kcontrol_news = kc;
8facf84bcf575e Peter Ujfalusi       2021-09-02  1461  	dev_dbg(tplg->dev, "ASoC: template %s with %d/%d/%d (mixer/enum/bytes) control\n",
8facf84bcf575e Peter Ujfalusi       2021-09-02  1462  		w->name, mixer_count, enum_count, bytes_count);
8a9782346dccd8 Liam Girdwood        2015-05-29  1463  
8a9782346dccd8 Liam Girdwood        2015-05-29  1464  widget:
8a9782346dccd8 Liam Girdwood        2015-05-29  1465  	ret = soc_tplg_widget_load(tplg, &template, w);
8a9782346dccd8 Liam Girdwood        2015-05-29  1466  	if (ret < 0)
8a9782346dccd8 Liam Girdwood        2015-05-29  1467  		goto hdr_err;
8a9782346dccd8 Liam Girdwood        2015-05-29  1468  
8a9782346dccd8 Liam Girdwood        2015-05-29  1469  	/* card dapm mutex is held by the core if we are loading topology
8a9782346dccd8 Liam Girdwood        2015-05-29  1470  	 * data during sound card init. */
8a9782346dccd8 Liam Girdwood        2015-05-29  1471  	if (card->instantiated)
8a9782346dccd8 Liam Girdwood        2015-05-29  1472  		widget = snd_soc_dapm_new_control(dapm, &template);
8a9782346dccd8 Liam Girdwood        2015-05-29  1473  	else
8a9782346dccd8 Liam Girdwood        2015-05-29  1474  		widget = snd_soc_dapm_new_control_unlocked(dapm, &template);
37e1df8c95e2c8 Linus Walleij        2017-01-13  1475  	if (IS_ERR(widget)) {
37e1df8c95e2c8 Linus Walleij        2017-01-13  1476  		ret = PTR_ERR(widget);
8a9782346dccd8 Liam Girdwood        2015-05-29  1477  		goto hdr_err;
8a9782346dccd8 Liam Girdwood        2015-05-29  1478  	}
8a9782346dccd8 Liam Girdwood        2015-05-29  1479  
8a9782346dccd8 Liam Girdwood        2015-05-29  1480  	widget->dobj.type = SND_SOC_DOBJ_WIDGET;
eea3dd4f1247aa Mengdong Lin         2016-11-25  1481  	widget->dobj.widget.kcontrol_type = kcontrol_type;
8a9782346dccd8 Liam Girdwood        2015-05-29  1482  	widget->dobj.ops = tplg->ops;
8a9782346dccd8 Liam Girdwood        2015-05-29  1483  	widget->dobj.index = tplg->index;
8a9782346dccd8 Liam Girdwood        2015-05-29  1484  	list_add(&widget->dobj.list, &tplg->comp->dobj_list);
ebd259d33a900b Liam Girdwood        2017-06-09  1485  
ebd259d33a900b Liam Girdwood        2017-06-09  1486  	ret = soc_tplg_widget_ready(tplg, widget, w);
ebd259d33a900b Liam Girdwood        2017-06-09  1487  	if (ret < 0)
ebd259d33a900b Liam Girdwood        2017-06-09  1488  		goto ready_err;
ebd259d33a900b Liam Girdwood        2017-06-09  1489  
7620fe9161cec2 Bard liao            2019-01-25  1490  	kfree(template.sname);
7620fe9161cec2 Bard liao            2019-01-25  1491  	kfree(template.name);
7620fe9161cec2 Bard liao            2019-01-25  1492  
8a9782346dccd8 Liam Girdwood        2015-05-29  1493  	return 0;
8a9782346dccd8 Liam Girdwood        2015-05-29  1494  
ebd259d33a900b Liam Girdwood        2017-06-09  1495  ready_err:
841fb1096713bd Amadeusz Sławiński   2020-10-30  1496  	remove_widget(widget->dapm->component, &widget->dobj, SOC_TPLG_PASS_WIDGET);
ebd259d33a900b Liam Girdwood        2017-06-09  1497  	snd_soc_dapm_free_widget(widget);
8a9782346dccd8 Liam Girdwood        2015-05-29  1498  hdr_err:
8a9782346dccd8 Liam Girdwood        2015-05-29  1499  	kfree(template.sname);
8a9782346dccd8 Liam Girdwood        2015-05-29  1500  err:
8a9782346dccd8 Liam Girdwood        2015-05-29  1501  	kfree(template.name);
8a9782346dccd8 Liam Girdwood        2015-05-29  1502  	return ret;
8a9782346dccd8 Liam Girdwood        2015-05-29  1503  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

