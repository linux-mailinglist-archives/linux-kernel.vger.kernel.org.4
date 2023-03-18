Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C1A6BF927
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 10:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCRJHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 05:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRJHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 05:07:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF87893EE;
        Sat, 18 Mar 2023 02:07:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r29so6273781wra.13;
        Sat, 18 Mar 2023 02:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679130448;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=StiB05oWOtccfBFyxUOqwfZL6UP5KdhkEBJ9XeVGvs0=;
        b=d+QVCxbm+Lx/zFV2tcIUb6aoyA/qcw2F47zcO+ynVvVJq/g/phfdUiylBUAeZ6efKC
         WXjsNt7PA2U2XM72lXerVGEiw936tOtcKMoSZ9M+SS4I9Kw7G+2WGKOvKihEkt0dwB3r
         0lAVaZ48iigDf8nGIaj5k05l1p3seOujxeXhoZZPmSD3hP6WZyQqP2BEUDNBKzoyeDND
         anojXKyn3qsHp7ZzE8ogpuGj8HbnZW4g2BUinAEKA659RDjjzS9JfyBKb7tcsDCK5ITv
         ntcQI3CCiNUilsqYR57L1Aoyxe79/mRuQgc1O2EhAyBFA9ppFTYOWSyJNPLlk0bG//uV
         J3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679130448;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StiB05oWOtccfBFyxUOqwfZL6UP5KdhkEBJ9XeVGvs0=;
        b=TR6TjcW5KXUJhh/XxssUr7vSzTmJ0i/5ZBoTXKjojyz1qluXb52vhhrA4k3+L0sGw+
         zga5dImU/Wjae/qcj1xLCh/59Of6thw1EgePg5cAHPXHmb2HgcRHnsg46dhFfj9OsrTg
         hlkXM+91mbRax+kyUzc148GIvD/RmTCqxOzWmbVKlNYbY+T6P/Gbas6S7YgovUyuEI1J
         IQO0wn4etzdHiPdunk+IFU1F9Zjy8O5deGAjmcR52o0v/mLMPowfS0OW0o3opD2+FqCp
         7ba66BnjsXGlUSg5caLX1X9hAabOT7usJTXzYMI93bNef3d8y1lhBryi3NlBE12PpY3N
         yILA==
X-Gm-Message-State: AO0yUKXKscm+KUR/+6wwZp0TC5s4lMIF1JM+OL5TQMBTCEaap/aw8Jjm
        JxfvJbM1YAd/VDYbU8AA4Y8=
X-Google-Smtp-Source: AK7set+3sxNjpfXrvGwG/TLnFV2s6obmuQe/MwcEbzCyaLkj3kYO3i3Rw0yRVqBZD8fpE3tPCF9P1w==
X-Received: by 2002:adf:f2d1:0:b0:2c5:5a65:79a0 with SMTP id d17-20020adff2d1000000b002c55a6579a0mr9818015wrp.53.1679130448103;
        Sat, 18 Mar 2023 02:07:28 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d4d52000000b002d1e49cff35sm3862137wru.40.2023.03.18.02.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 02:07:27 -0700 (PDT)
Date:   Sat, 18 Mar 2023 12:07:14 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev, rui.zhang@intel.com,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/11] thermal/core: Alloc-copy-free the thermal zone
 parameters structure
Message-ID: <1a1d6830-85f3-413e-af01-029c75580c65@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307133735.90772-11-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-drivers-intel_pch_thermal-Use-thermal-driver-device-to-write-a-trace/20230307-223759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230307133735.90772-11-daniel.lezcano%40linaro.org
patch subject: [PATCH v1 10/11] thermal/core: Alloc-copy-free the thermal zone parameters structure
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20230316/202303160005.1BnLbm4F-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303160005.1BnLbm4F-lkp@intel.com/

smatch warnings:
drivers/thermal/thermal_core.c:1388 thermal_zone_device_register_with_trips() error: uninitialized symbol 'result'.

vim +/result +1388 drivers/thermal/thermal_core.c

eb7be329bd93b7 drivers/thermal/thermal_core.c Eduardo Valentin    2016-11-07  1209  struct thermal_zone_device *
fae11de507f0e4 drivers/thermal/thermal_core.c Daniel Lezcano      2022-07-22  1210  thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int num_trips, int mask,
eb7be329bd93b7 drivers/thermal/thermal_core.c Eduardo Valentin    2016-11-07  1211  					void *devdata, struct thermal_zone_device_ops *ops,
eb7be329bd93b7 drivers/thermal/thermal_core.c Eduardo Valentin    2016-11-07  1212  					struct thermal_zone_params *tzp, int passive_delay,
eb7be329bd93b7 drivers/thermal/thermal_core.c Eduardo Valentin    2016-11-07  1213  					int polling_delay)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1214  {
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1215  	struct thermal_zone_device *tz;
adc8749b150c51 drivers/thermal/thermal_core.c Yue Hu              2019-08-07  1216  	int id;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1217  	int result;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1218  	int count;
e33df1d2f3a014 drivers/thermal/thermal_core.c Javi Merino         2015-02-26  1219  	struct thermal_governor *governor;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1220  
67eed44b8a8ae7 drivers/thermal/thermal_core.c Amit Kucheria       2019-07-12  1221  	if (!type || strlen(type) == 0) {
3f95ac324535ea drivers/thermal/thermal_core.c Daniel Lezcano      2022-07-22  1222  		pr_err("No thermal zone type defined\n");
54fa38cc2eda43 drivers/thermal/thermal_core.c Eduardo Valentin    2016-11-07  1223  		return ERR_PTR(-EINVAL);
67eed44b8a8ae7 drivers/thermal/thermal_core.c Amit Kucheria       2019-07-12  1224  	}
54fa38cc2eda43 drivers/thermal/thermal_core.c Eduardo Valentin    2016-11-07  1225  
c71d8035f1b77d drivers/thermal/thermal_core.c Lad Prabhakar       2022-09-09  1226  	if (strlen(type) >= THERMAL_NAME_LENGTH) {
3f95ac324535ea drivers/thermal/thermal_core.c Daniel Lezcano      2022-07-22  1227  		pr_err("Thermal zone name (%s) too long, should be under %d chars\n",
67eed44b8a8ae7 drivers/thermal/thermal_core.c Amit Kucheria       2019-07-12  1228  		       type, THERMAL_NAME_LENGTH);
3e6fda5c115982 drivers/thermal/thermal.c      Thomas Sujith       2008-02-15  1229  		return ERR_PTR(-EINVAL);
67eed44b8a8ae7 drivers/thermal/thermal_core.c Amit Kucheria       2019-07-12  1230  	}
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1231  
82b1ec794d7014 drivers/thermal/thermal_core.c Sumeet Pawnikar     2022-09-27  1232  	/*
82b1ec794d7014 drivers/thermal/thermal_core.c Sumeet Pawnikar     2022-09-27  1233  	 * Max trip count can't exceed 31 as the "mask >> num_trips" condition.
82b1ec794d7014 drivers/thermal/thermal_core.c Sumeet Pawnikar     2022-09-27  1234  	 * For example, shifting by 32 will result in compiler warning:
82b1ec794d7014 drivers/thermal/thermal_core.c Sumeet Pawnikar     2022-09-27  1235  	 * warning: right shift count >= width of type [-Wshift-count- overflow]
82b1ec794d7014 drivers/thermal/thermal_core.c Sumeet Pawnikar     2022-09-27  1236  	 *
82b1ec794d7014 drivers/thermal/thermal_core.c Sumeet Pawnikar     2022-09-27  1237  	 * Also "mask >> num_trips" will always be true with 32 bit shift.
82b1ec794d7014 drivers/thermal/thermal_core.c Sumeet Pawnikar     2022-09-27  1238  	 * E.g. mask = 0x80000000 for trip id 31 to be RW. Then
82b1ec794d7014 drivers/thermal/thermal_core.c Sumeet Pawnikar     2022-09-27  1239  	 * mask >> 32 = 0x80000000
82b1ec794d7014 drivers/thermal/thermal_core.c Sumeet Pawnikar     2022-09-27  1240  	 * This will result in failure for the below condition.
82b1ec794d7014 drivers/thermal/thermal_core.c Sumeet Pawnikar     2022-09-27  1241  	 *
82b1ec794d7014 drivers/thermal/thermal_core.c Sumeet Pawnikar     2022-09-27  1242  	 * Check will be true when the bit 31 of the mask is set.
82b1ec794d7014 drivers/thermal/thermal_core.c Sumeet Pawnikar     2022-09-27  1243  	 * 32 bit shift will cause overflow of 4 byte integer.
82b1ec794d7014 drivers/thermal/thermal_core.c Sumeet Pawnikar     2022-09-27  1244  	 */
82b1ec794d7014 drivers/thermal/thermal_core.c Sumeet Pawnikar     2022-09-27  1245  	if (num_trips > (BITS_PER_TYPE(int) - 1) || num_trips < 0 || mask >> num_trips) {
3f95ac324535ea drivers/thermal/thermal_core.c Daniel Lezcano      2022-07-22  1246  		pr_err("Incorrect number of thermal trips\n");
3e6fda5c115982 drivers/thermal/thermal.c      Thomas Sujith       2008-02-15  1247  		return ERR_PTR(-EINVAL);
67eed44b8a8ae7 drivers/thermal/thermal_core.c Amit Kucheria       2019-07-12  1248  	}
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1249  
67eed44b8a8ae7 drivers/thermal/thermal_core.c Amit Kucheria       2019-07-12  1250  	if (!ops) {
3f95ac324535ea drivers/thermal/thermal_core.c Daniel Lezcano      2022-07-22  1251  		pr_err("Thermal zone device ops not defined\n");
3e6fda5c115982 drivers/thermal/thermal.c      Thomas Sujith       2008-02-15  1252  		return ERR_PTR(-EINVAL);
67eed44b8a8ae7 drivers/thermal/thermal_core.c Amit Kucheria       2019-07-12  1253  	}
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1254  
7c3d5c20dc169e drivers/thermal/thermal_core.c Daniel Lezcano      2022-10-03  1255  	if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp) && !trips)
6b2aa51d698492 drivers/thermal/thermal_sys.c  Eduardo Valentin    2013-01-02  1256  		return ERR_PTR(-EINVAL);
6b2aa51d698492 drivers/thermal/thermal_sys.c  Eduardo Valentin    2013-01-02  1257  
9e0a9be24bdd61 drivers/thermal/thermal_core.c Rafael J. Wysocki   2023-01-23  1258  	if (!thermal_class)
9e0a9be24bdd61 drivers/thermal/thermal_core.c Rafael J. Wysocki   2023-01-23  1259  		return ERR_PTR(-ENODEV);
9e0a9be24bdd61 drivers/thermal/thermal_core.c Rafael J. Wysocki   2023-01-23  1260  
95e3ed1513494a drivers/thermal/thermal_core.c Eduardo Valentin    2016-11-07  1261  	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1262  	if (!tz)
3e6fda5c115982 drivers/thermal/thermal.c      Thomas Sujith       2008-02-15  1263  		return ERR_PTR(-ENOMEM);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1264  
a9813bacf35314 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1265  	if (tzp) {
a9813bacf35314 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1266  		tz->tzp = kmemdup(tzp, sizeof(*tzp), GFP_KERNEL);
a9813bacf35314 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1267  		if (!tz->tzp)
a9813bacf35314 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1268  			goto free_tz;

result = -ENOMEM;

a9813bacf35314 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1269  	}
a9813bacf35314 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1270  	
2d374139d5b0b5 drivers/thermal/thermal_sys.c  Zhang Rui           2012-06-27  1271  	INIT_LIST_HEAD(&tz->thermal_instances);
b31ef8285b19ec drivers/thermal/thermal_core.c Matthew Wilcox      2016-12-21  1272  	ida_init(&tz->ida);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1273  	mutex_init(&tz->lock);
5a5b7d8d541684 drivers/thermal/thermal_core.c keliu               2022-05-27  1274  	id = ida_alloc(&thermal_tz_ida, GFP_KERNEL);
adc8749b150c51 drivers/thermal/thermal_core.c Yue Hu              2019-08-07  1275  	if (id < 0) {
adc8749b150c51 drivers/thermal/thermal_core.c Yue Hu              2019-08-07  1276  		result = id;
a9813bacf35314 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1277  		goto free_tzp;
adc8749b150c51 drivers/thermal/thermal_core.c Yue Hu              2019-08-07  1278  	}
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1279  
adc8749b150c51 drivers/thermal/thermal_core.c Yue Hu              2019-08-07  1280  	tz->id = id;
1e6c8fb8b8d3e9 drivers/thermal/thermal_core.c Wolfram Sang        2022-08-18  1281  	strscpy(tz->type, type, sizeof(tz->type));
d7203eedf4f68e drivers/thermal/thermal_core.c Daniel Lezcano      2020-12-10  1282  
d7203eedf4f68e drivers/thermal/thermal_core.c Daniel Lezcano      2020-12-10  1283  	if (!ops->critical)
d7203eedf4f68e drivers/thermal/thermal_core.c Daniel Lezcano      2020-12-10  1284  		ops->critical = thermal_zone_device_critical;
d7203eedf4f68e drivers/thermal/thermal_core.c Daniel Lezcano      2020-12-10  1285  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1286  	tz->ops = ops;
9e0a9be24bdd61 drivers/thermal/thermal_core.c Rafael J. Wysocki   2023-01-23  1287  	tz->device.class = thermal_class;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1288  	tz->devdata = devdata;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1289  	tz->trips = trips;
e5bfcd30f88fdb drivers/thermal/thermal_core.c Daniel Lezcano      2022-07-22  1290  	tz->num_trips = num_trips;
1c600861fa6fd8 drivers/thermal/thermal_core.c Eduardo Valentin    2016-11-07  1291  
17d399cd9c8936 drivers/thermal/thermal_core.c Daniel Lezcano      2020-12-16  1292  	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
17d399cd9c8936 drivers/thermal/thermal_core.c Daniel Lezcano      2020-12-16  1293  	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
17d399cd9c8936 drivers/thermal/thermal_core.c Daniel Lezcano      2020-12-16  1294  
4d0fe7490d7f4d drivers/thermal/thermal_core.c Eduardo Valentin    2016-11-07  1295  	/* sys I/F */
1c600861fa6fd8 drivers/thermal/thermal_core.c Eduardo Valentin    2016-11-07  1296  	/* Add nodes that are always present via .groups */
4d0fe7490d7f4d drivers/thermal/thermal_core.c Eduardo Valentin    2016-11-07  1297  	result = thermal_zone_create_device_groups(tz, mask);
4d0fe7490d7f4d drivers/thermal/thermal_core.c Eduardo Valentin    2016-11-07  1298  	if (result)
9d9ca1f9f04cf1 drivers/thermal/thermal_core.c Christophe Jaillet  2017-08-08  1299  		goto remove_id;
4d0fe7490d7f4d drivers/thermal/thermal_core.c Eduardo Valentin    2016-11-07  1300  
4511f7166a2deb drivers/thermal/thermal_core.c Chen Yu             2015-10-30  1301  	/* A new thermal zone needs to be updated anyway. */
4511f7166a2deb drivers/thermal/thermal_core.c Chen Yu             2015-10-30  1302  	atomic_set(&tz->need_update, 1);
b1569e99c795bf drivers/thermal/thermal_sys.c  Matthew Garrett     2008-12-03  1303  
4748f9687caaee drivers/thermal/thermal_core.c Yang Yingliang      2022-11-15  1304  	result = dev_set_name(&tz->device, "thermal_zone%d", tz->id);
4748f9687caaee drivers/thermal/thermal_core.c Yang Yingliang      2022-11-15  1305  	if (result) {
4748f9687caaee drivers/thermal/thermal_core.c Yang Yingliang      2022-11-15  1306  		thermal_zone_destroy_device_groups(tz);
4748f9687caaee drivers/thermal/thermal_core.c Yang Yingliang      2022-11-15  1307  		goto remove_id;
4748f9687caaee drivers/thermal/thermal_core.c Yang Yingliang      2022-11-15  1308  	}
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1309  	result = device_register(&tz->device);
9d9ca1f9f04cf1 drivers/thermal/thermal_core.c Christophe Jaillet  2017-08-08  1310  	if (result)
adc8749b150c51 drivers/thermal/thermal_core.c Yue Hu              2019-08-07  1311  		goto release_device;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1312  
e5bfcd30f88fdb drivers/thermal/thermal_core.c Daniel Lezcano      2022-07-22  1313  	for (count = 0; count < num_trips; count++) {
7c3d5c20dc169e drivers/thermal/thermal_core.c Daniel Lezcano      2022-10-03  1314  		struct thermal_trip trip;
7c3d5c20dc169e drivers/thermal/thermal_core.c Daniel Lezcano      2022-10-03  1315  
7c3d5c20dc169e drivers/thermal/thermal_core.c Daniel Lezcano      2022-10-03  1316  		result = thermal_zone_get_trip(tz, count, &trip);
7c3d5c20dc169e drivers/thermal/thermal_core.c Daniel Lezcano      2022-10-03  1317  		if (result)
81ad4276b505e9 drivers/thermal/thermal_core.c Zhang Rui           2016-03-18  1318  			set_bit(count, &tz->trips_disabled);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1319  	}
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1320  
a4a15485fbba44 drivers/thermal/thermal_sys.c  Durgadoss R         2012-09-18  1321  	/* Update 'this' zone's governor information */
a4a15485fbba44 drivers/thermal/thermal_sys.c  Durgadoss R         2012-09-18  1322  	mutex_lock(&thermal_governor_lock);
a4a15485fbba44 drivers/thermal/thermal_sys.c  Durgadoss R         2012-09-18  1323  
a4a15485fbba44 drivers/thermal/thermal_sys.c  Durgadoss R         2012-09-18  1324  	if (tz->tzp)
e33df1d2f3a014 drivers/thermal/thermal_core.c Javi Merino         2015-02-26  1325  		governor = __find_governor(tz->tzp->governor_name);
a4a15485fbba44 drivers/thermal/thermal_sys.c  Durgadoss R         2012-09-18  1326  	else
e33df1d2f3a014 drivers/thermal/thermal_core.c Javi Merino         2015-02-26  1327  		governor = def_governor;
e33df1d2f3a014 drivers/thermal/thermal_core.c Javi Merino         2015-02-26  1328  
e33df1d2f3a014 drivers/thermal/thermal_core.c Javi Merino         2015-02-26  1329  	result = thermal_set_governor(tz, governor);
e33df1d2f3a014 drivers/thermal/thermal_core.c Javi Merino         2015-02-26  1330  	if (result) {
e33df1d2f3a014 drivers/thermal/thermal_core.c Javi Merino         2015-02-26  1331  		mutex_unlock(&thermal_governor_lock);
e33df1d2f3a014 drivers/thermal/thermal_core.c Javi Merino         2015-02-26  1332  		goto unregister;
e33df1d2f3a014 drivers/thermal/thermal_core.c Javi Merino         2015-02-26  1333  	}
a4a15485fbba44 drivers/thermal/thermal_sys.c  Durgadoss R         2012-09-18  1334  
a4a15485fbba44 drivers/thermal/thermal_sys.c  Durgadoss R         2012-09-18  1335  	mutex_unlock(&thermal_governor_lock);
a4a15485fbba44 drivers/thermal/thermal_sys.c  Durgadoss R         2012-09-18  1336  
ccba4ffd9eff61 drivers/thermal/thermal_core.c Eduardo Valentin    2013-08-15  1337  	if (!tz->tzp || !tz->tzp->no_hwmon) {
e68b16abd91dca drivers/thermal/thermal.c      Zhang Rui           2008-04-21  1338  		result = thermal_add_hwmon_sysfs(tz);
e68b16abd91dca drivers/thermal/thermal.c      Zhang Rui           2008-04-21  1339  		if (result)
e68b16abd91dca drivers/thermal/thermal.c      Zhang Rui           2008-04-21  1340  			goto unregister;
ccba4ffd9eff61 drivers/thermal/thermal_core.c Eduardo Valentin    2013-08-15  1341  	}
e68b16abd91dca drivers/thermal/thermal.c      Zhang Rui           2008-04-21  1342  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1343  	mutex_lock(&thermal_list_lock);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1344  	list_add_tail(&tz->node, &thermal_tz_list);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1345  	mutex_unlock(&thermal_list_lock);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1346  
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1347  	if (tzp && tzp->linked_dev) {
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1348  		result = sysfs_create_link(&tzp->linked_dev->kobj,
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1349  					   &tz->device.kobj, "thermal_zone");
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1350  		if (result)
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1351  			goto out_list_del;
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1352  
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1353  		result = sysfs_create_link(&tz->device.kobj,
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1354  					   &tzp->linked_dev->kobj, "device");
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1355  		if (result)
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1356  			goto out_del_link;
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1357  	}
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1358  
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R         2012-09-18  1359  	/* Bind cooling devices for this zone */
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R         2012-09-18  1360  	bind_tz(tz);
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R         2012-09-18  1361  
b659a30d7bdd5d drivers/thermal/thermal_core.c Eduardo Valentin    2016-11-07  1362  	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
b1569e99c795bf drivers/thermal/thermal_sys.c  Matthew Garrett     2008-12-03  1363  
d0df264fbd3c53 drivers/thermal/thermal_core.c Daniel Lezcano      2020-12-22  1364  	thermal_zone_device_init(tz);
4511f7166a2deb drivers/thermal/thermal_core.c Chen Yu             2015-10-30  1365  	/* Update the new thermal zone and mark it as already updated. */
4511f7166a2deb drivers/thermal/thermal_core.c Chen Yu             2015-10-30  1366  	if (atomic_cmpxchg(&tz->need_update, 1, 0))
0e70f466fb910a drivers/thermal/thermal_core.c Srinivas Pandruvada 2016-08-26  1367  		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
b1569e99c795bf drivers/thermal/thermal_sys.c  Matthew Garrett     2008-12-03  1368  
55cdf0a283b876 drivers/thermal/thermal_core.c Daniel Lezcano      2020-07-06  1369  	thermal_notify_tz_create(tz->id, tz->type);
55cdf0a283b876 drivers/thermal/thermal_core.c Daniel Lezcano      2020-07-06  1370  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1371  	return tz;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1372  
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1373  out_del_link:
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1374  	sysfs_remove_link(&tz->device.kobj, "thermal_zone");
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1375  out_list_del:
70edc3ef596502 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1376  	list_del(&tz->node);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1377  unregister:
adc8749b150c51 drivers/thermal/thermal_core.c Yue Hu              2019-08-07  1378  	device_del(&tz->device);
adc8749b150c51 drivers/thermal/thermal_core.c Yue Hu              2019-08-07  1379  release_device:
adc8749b150c51 drivers/thermal/thermal_core.c Yue Hu              2019-08-07  1380  	put_device(&tz->device);
adc8749b150c51 drivers/thermal/thermal_core.c Yue Hu              2019-08-07  1381  	tz = NULL;
9d9ca1f9f04cf1 drivers/thermal/thermal_core.c Christophe Jaillet  2017-08-08  1382  remove_id:
5a5b7d8d541684 drivers/thermal/thermal_core.c keliu               2022-05-27  1383  	ida_free(&thermal_tz_ida, id);
a9813bacf35314 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1384  free_tzp:
a9813bacf35314 drivers/thermal/thermal_core.c Daniel Lezcano      2023-03-07  1385  	kfree(tz->tzp);
9d9ca1f9f04cf1 drivers/thermal/thermal_core.c Christophe Jaillet  2017-08-08  1386  free_tz:
9d9ca1f9f04cf1 drivers/thermal/thermal_core.c Christophe Jaillet  2017-08-08  1387  	kfree(tz);
9d9ca1f9f04cf1 drivers/thermal/thermal_core.c Christophe Jaillet  2017-08-08 @1388  	return ERR_PTR(result);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui           2008-01-17  1389  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

