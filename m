Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC8B5B4E92
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiIKLvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiIKLu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:50:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F7813EA9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662897054; x=1694433054;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FEmGgkzRh6R1cSeBriL+cP6FYOlQwqhc6oxNoDskjIo=;
  b=N6BImvBMXOQlxZsuG5/QMnoC+EanEUswT0ocn0xx7iBCrh0vo1hmtro8
   gjSP5/9mvckDKEDOhcJstsMMabaqSYmKouSpdDvH05GSiQD7GDnOfUhGy
   tr7aExOFBVOi5JNy2HSIh92uRjJ4lop2l2fjKGgzw0H/5Bua0Vswi/1Fs
   AdR6A7v/wlJH0m67IzGXpMs0TQ+qg9/w+KGLFY/pGX+bsbsWrWU6dBA8y
   6T2KEv8yYsW2XGjesqu0r2kD8Ogb+t4Qf9uPCHajLeuVGNJGoCR1hfxIh
   W130jezAzntMhJFQttXMEpKs6StMsla9AE95I6Wv4YeoXbl+G7VzvU9JF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="277451238"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="277451238"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 04:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="944313536"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Sep 2022 04:50:53 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXLUC-0001Ol-1z;
        Sun, 11 Sep 2022 11:50:52 +0000
Date:   Sun, 11 Sep 2022 19:49:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morimoto:sound2-v6.0-2022-09-09-v2 49/55] sound/soc/soc-dapm.c:4162
 snd_soc_dapm_new_dai() warn: inconsistent indenting
Message-ID: <202209111917.cMYmWWoC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/morimoto/linux sound2-v6.0-2022-09-09-v2
head:   10a201235415b4393d984aa83f1c33cd3d73061b
commit: 1e5328f3d4518fc1ef26c0672bb78b426d6ce280 [49/55] hoge
config: m68k-randconfig-m041-20220911 (https://download.01.org/0day-ci/archive/20220911/202209111917.cMYmWWoC-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
sound/soc/soc-dapm.c:4162 snd_soc_dapm_new_dai() warn: inconsistent indenting
sound/soc/soc-dapm.c:4351 dapm_connect_dai_pair() warn: inconsistent indenting
sound/soc/soc-pcm.c:1986 dpcm_be_dai_hw_params() warn: inconsistent indenting
sound/soc/generic/simple-card-utils.c:493 asoc_simple_be_hw_params_fixup() warn: inconsistent indenting

Old smatch warnings:
sound/soc/soc-dapm.c:4376 dapm_connect_dai_pair() warn: inconsistent indenting
sound/soc/soc-pcm.c:1991 dpcm_be_dai_hw_params() warn: inconsistent indenting

vim +4162 sound/soc/soc-dapm.c

  4122	
  4123	static struct snd_soc_dapm_widget *
  4124	snd_soc_dapm_new_dai(struct snd_soc_card *card,
  4125			     struct snd_pcm_substream *substream,
  4126			     char *id)
  4127	{
  4128		struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
  4129		struct snd_soc_dapm_widget template;
  4130		struct snd_soc_dapm_widget *w;
  4131		const struct snd_kcontrol_new *kcontrol_news;
  4132		int num_kcontrols;
  4133		const char **w_param_text;
  4134		unsigned long private_value = 0;
  4135		char *link_name;
  4136		int ret = -ENOMEM;
  4137	
  4138		link_name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-%s",
  4139					   rtd->dai_link->name, id);
  4140		if (!link_name)
  4141			goto name_fail;
  4142	
  4143		/* allocate memory for control, only in case of multiple configs */
  4144		w_param_text	= NULL;
  4145		kcontrol_news	= NULL;
  4146		num_kcontrols	= 0;
  4147		if (rtd->dai_link->num_params > 1) {
  4148			w_param_text = devm_kcalloc(card->dev,
  4149						    rtd->dai_link->num_params,
  4150						    sizeof(char *), GFP_KERNEL);
  4151			if (!w_param_text)
  4152				goto param_fail;
  4153	
  4154			num_kcontrols = 1;
  4155			kcontrol_news = snd_soc_dapm_alloc_kcontrol(card, link_name,
  4156								    rtd->dai_link->params,
  4157								    rtd->dai_link->num_params,
  4158								    w_param_text, &private_value);
  4159			if (!kcontrol_news)
  4160				goto param_fail;
  4161		}
> 4162	printk("------new dai %s\n", link_name);
  4163		memset(&template, 0, sizeof(template));
  4164		template.reg		= SND_SOC_NOPM;
  4165		template.id		= snd_soc_dapm_dai_link;
  4166		template.name		= link_name;
  4167		template.event		= snd_soc_dai_link_event;
  4168		template.event_flags	= SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
  4169					  SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD;
  4170		template.kcontrol_news	= kcontrol_news;
  4171		template.num_kcontrols	= num_kcontrols;
  4172	
  4173		dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);
  4174	
  4175		w = snd_soc_dapm_new_control_unlocked(&card->dapm, &template);
  4176		if (IS_ERR(w)) {
  4177			ret = PTR_ERR(w);
  4178			goto outfree_kcontrol_news;
  4179		}
  4180	
  4181		w->priv = substream;
  4182	
  4183		return w;
  4184	
  4185	outfree_kcontrol_news:
  4186		devm_kfree(card->dev, (void *)template.kcontrol_news);
  4187		snd_soc_dapm_free_kcontrol(card, &private_value,
  4188					   rtd->dai_link->num_params, w_param_text);
  4189	param_fail:
  4190		devm_kfree(card->dev, link_name);
  4191	name_fail:
  4192		dev_err(rtd->dev, "ASoC: Failed to create %s-%s widget: %d\n",
  4193			rtd->dai_link->name, id, ret);
  4194		return ERR_PTR(ret);
  4195	}
  4196	
  4197	/**
  4198	 * snd_soc_dapm_new_dai_widgets - Create new DAPM widgets
  4199	 * @dapm: DAPM context
  4200	 * @dai: parent DAI
  4201	 *
  4202	 * Returns 0 on success, error code otherwise.
  4203	 */
  4204	int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
  4205					 struct snd_soc_dai *dai)
  4206	{
  4207		struct snd_soc_dapm_widget template;
  4208		struct snd_soc_dapm_widget *w;
  4209		int stream;
  4210	
  4211		WARN_ON(dapm->dev != dai->dev);
  4212	
  4213		memset(&template, 0, sizeof(template));
  4214		template.reg = SND_SOC_NOPM;
  4215	
  4216		stream = SNDRV_PCM_STREAM_PLAYBACK;
  4217		if (dai->driver->playback.stream_name) {
  4218			template.id = snd_soc_dapm_dai_in;
  4219			template.name = dai->driver->playback.stream_name;
  4220			template.sname = dai->driver->playback.stream_name;
  4221	
  4222			dev_dbg(dai->dev, "ASoC: adding %s widget\n",
  4223				template.name);
  4224	
  4225			w = snd_soc_dapm_new_control_unlocked(dapm, &template);
  4226			if (IS_ERR(w))
  4227				return PTR_ERR(w);
  4228	
  4229			w->priv = dai;
  4230			snd_soc_dai_set_widget(dai, stream, w);
  4231		}
  4232	
  4233		stream = SNDRV_PCM_STREAM_CAPTURE;
  4234		if (dai->driver->capture.stream_name) {
  4235			template.id = snd_soc_dapm_dai_out;
  4236			template.name = dai->driver->capture.stream_name;
  4237			template.sname = dai->driver->capture.stream_name;
  4238	
  4239			dev_dbg(dai->dev, "ASoC: adding %s widget\n",
  4240				template.name);
  4241	
  4242			w = snd_soc_dapm_new_control_unlocked(dapm, &template);
  4243			if (IS_ERR(w))
  4244				return PTR_ERR(w);
  4245	
  4246			w->priv = dai;
  4247			snd_soc_dai_set_widget(dai, stream, w);
  4248		}
  4249	
  4250		return 0;
  4251	}
  4252	EXPORT_SYMBOL_GPL(snd_soc_dapm_new_dai_widgets);
  4253	
  4254	int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
  4255	{
  4256		struct snd_soc_dapm_widget *dai_w, *w;
  4257		struct snd_soc_dapm_widget *src, *sink;
  4258		struct snd_soc_dai *dai;
  4259	
  4260		/* For each DAI widget... */
  4261		for_each_card_widgets(card, dai_w) {
  4262			switch (dai_w->id) {
  4263			case snd_soc_dapm_dai_in:
  4264			case snd_soc_dapm_dai_out:
  4265				break;
  4266			default:
  4267				continue;
  4268			}
  4269	
  4270			/* let users know there is no DAI to link */
  4271			if (!dai_w->priv) {
  4272				dev_dbg(card->dev, "dai widget %s has no DAI\n",
  4273					dai_w->name);
  4274				continue;
  4275			}
  4276	
  4277			dai = dai_w->priv;
  4278	
  4279			/* ...find all widgets with the same stream and link them */
  4280			for_each_card_widgets(card, w) {
  4281				if (w->dapm != dai_w->dapm)
  4282					continue;
  4283	
  4284				switch (w->id) {
  4285				case snd_soc_dapm_dai_in:
  4286				case snd_soc_dapm_dai_out:
  4287					continue;
  4288				default:
  4289					break;
  4290				}
  4291	
  4292				if (!w->sname || !strstr(w->sname, dai_w->sname))
  4293					continue;
  4294	
  4295				if (dai_w->id == snd_soc_dapm_dai_in) {
  4296					src = dai_w;
  4297					sink = w;
  4298				} else {
  4299					src = w;
  4300					sink = dai_w;
  4301				}
  4302				dev_dbg(dai->dev, "%s -> %s\n", src->name, sink->name);
  4303				snd_soc_dapm_add_path(w->dapm, src, sink, NULL, NULL);
  4304			}
  4305		}
  4306	
  4307		return 0;
  4308	}
  4309	
  4310	static void dapm_connect_dai_routes(struct snd_soc_dapm_context *dapm,
  4311					    struct snd_soc_dai *src_dai,
  4312					    struct snd_soc_dapm_widget *src,
  4313					    struct snd_soc_dapm_widget *dai,
  4314					    struct snd_soc_dai *sink_dai,
  4315					    struct snd_soc_dapm_widget *sink)
  4316	{
  4317		dev_dbg(dapm->dev, "connected DAI link %s:%s -> %s:%s\n",
  4318			src_dai->component->name, src->name,
  4319			sink_dai->component->name, sink->name);
  4320	
  4321		if (dai) {
  4322			snd_soc_dapm_add_path(dapm, src, dai, NULL, NULL);
  4323			src = dai;
  4324		}
  4325	
  4326		snd_soc_dapm_add_path(dapm, src, sink, NULL, NULL);
  4327	}
  4328	
  4329	static int convert_stream(int stream)
  4330	{
  4331		if (stream == SNDRV_PCM_STREAM_CAPTURE)
  4332			return SNDRV_PCM_STREAM_PLAYBACK;
  4333	
  4334		return SNDRV_PCM_STREAM_CAPTURE;
  4335	}
  4336	
  4337	static void dapm_connect_dai_pair(struct snd_soc_card *card,
  4338					  struct snd_soc_pcm_runtime *rtd,
  4339					  struct snd_soc_dai *codec_dai,
  4340					  struct snd_soc_dai *cpu_dai)
  4341	{
  4342		struct snd_soc_dai_link *dai_link = rtd->dai_link;
  4343		struct snd_soc_dapm_widget *codec, *cpu;
  4344		struct snd_soc_dai *src_dai[]		= { cpu_dai,	codec_dai };
  4345		struct snd_soc_dai *sink_dai[]		= { codec_dai,	cpu_dai };
  4346		struct snd_soc_dapm_widget **src[]	= { &cpu,	&codec };
  4347		struct snd_soc_dapm_widget **sink[]	= { &codec,	&cpu };
  4348		char *widget_name[]			= { "playback",	"capture" };
  4349		int stream;
  4350	
> 4351	printk("----dai pair %s: %s: %s\n", dai_link->name, cpu_dai->name, codec_dai->name);
  4352	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
