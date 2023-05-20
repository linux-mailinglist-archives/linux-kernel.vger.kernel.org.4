Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC04870A66D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 10:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjETIfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 04:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjETIfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 04:35:23 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9837D19A
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 01:35:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so27716685e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684571720; x=1687163720;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vyFh+4f0r6tsvCpGiQdyclpXVepuJYnll+JfgHmo8Vk=;
        b=jr1+1zLs7LJg88GxhOsvuJyoodRmLzBLriga5vcieIMQ6ftFydM3/6YyybHjCiH6mR
         5eKIZrdciWlokPI8hqb6P4/60P661qw3praRX/R3kwruRqrijZFtNR2EcH2br3k1wW6w
         E3mplcov1IHyzwa/tq8RKhw1sxNg5i+Pr9S8Tb1w8GEBeoJjDcDo5pgVo/ZDXsDVz3NW
         OEa1Kf0RAjdCBRkeD6wONWha3ZFJXYMK1+WBLnmhngSrnABIzYvnYxGEdM2NSQ9no7Py
         4GO0VB9QhUOPhzFHEUYXGTNTGmy9ukfQXGpSl5zUulK1H4u85Ki1JgcxUm1lcF52Qxrn
         cMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684571720; x=1687163720;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vyFh+4f0r6tsvCpGiQdyclpXVepuJYnll+JfgHmo8Vk=;
        b=M1gWGKHHSfLIXLVb7Zn0GScWC8dlxc3DO0MuOlJMQvW6aPZiRqyGK58V86OCFVgJuT
         ck1ociHbYjVyNE85kqKb966rTyNXsf1Eoi8Td/MNaK1p1qeTRhmrE9hG71clvt24NTcj
         B4Pi7cAfHh/cojr+ri4wlHQRfk2VVwh2y7sLoHwpJfC7nmTpqW8wohKFzyfcQhtzseo9
         tKjaB131PCu57qCOJlj2HZlACUZPbQiyHNH1IKhZ6QzsHhQFfvh8IOIPqdbFTU0A48aF
         SMJrMWi9kLW1LzX4QZJPgcfbQw/ZNaVckHKwkmQNjQjcEfyHYzmS4hFs4v5vd+OLJ3zA
         6GsA==
X-Gm-Message-State: AC+VfDzXlg82nYMHQQNEEvmM6jsvI0nlp0D2397fk7XQWa+iSz3yUtPb
        zQZultHcf5TdGeeIMFyOMyOy6g==
X-Google-Smtp-Source: ACHHUZ5i4XUrGngXFZw0SFwoaO2R/3ERgD06u0znG7OOJHY7IUVpZ0rOW9I4sEdeAknE+hKcPDOOXQ==
X-Received: by 2002:a05:600c:3652:b0:3f4:2300:e015 with SMTP id y18-20020a05600c365200b003f42300e015mr3066023wmq.5.1684571720033;
        Sat, 20 May 2023 01:35:20 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u3-20020a7bc043000000b003f4f89bc48dsm4800809wmc.15.2023.05.20.01.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 01:35:18 -0700 (PDT)
Date:   Sat, 20 May 2023 11:35:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: drivers/soundwire/qcom.c:1269 qcom_swrm_get_port_config() error:
 buffer overflow 'ctrl->pconfig' 14 <= 14
Message-ID: <ea98850b-3b56-4306-87be-a5853a3cdf50@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d635f6cc934bcd467c5d67148ece74632fd96abf
commit: 2367e0ecb498764e95cfda691ff0828f7d25f9a4 soundwire: qcom: gracefully handle too many ports in DT
config: ia64-randconfig-m041-20230514
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202305201301.sCJ8UDKV-lkp@intel.com/

New smatch warnings:
drivers/soundwire/qcom.c:1269 qcom_swrm_get_port_config() error: buffer overflow 'ctrl->pconfig' 14 <= 14

Old smatch warnings:
drivers/soundwire/qcom.c:1270 qcom_swrm_get_port_config() error: buffer overflow 'ctrl->pconfig' 14 <= 14
drivers/soundwire/qcom.c:1271 qcom_swrm_get_port_config() error: buffer overflow 'ctrl->pconfig' 14 <= 14
drivers/soundwire/qcom.c:1272 qcom_swrm_get_port_config() error: buffer overflow 'ctrl->pconfig' 14 <= 14
drivers/soundwire/qcom.c:1273 qcom_swrm_get_port_config() error: buffer overflow 'ctrl->pconfig' 14 <= 14
drivers/soundwire/qcom.c:1274 qcom_swrm_get_port_config() error: buffer overflow 'ctrl->pconfig' 14 <= 14
drivers/soundwire/qcom.c:1275 qcom_swrm_get_port_config() error: buffer overflow 'ctrl->pconfig' 14 <= 14
drivers/soundwire/qcom.c:1276 qcom_swrm_get_port_config() error: buffer overflow 'ctrl->pconfig' 14 <= 14
drivers/soundwire/qcom.c:1277 qcom_swrm_get_port_config() error: buffer overflow 'ctrl->pconfig' 14 <= 14

vim +1269 drivers/soundwire/qcom.c

02efb49aa805cee Srinivas Kandagatla  2020-01-13  1183  static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1184  {
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1185  	struct device_node *np = ctrl->dev->of_node;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1186  	u8 off1[QCOM_SDW_MAX_PORTS];
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1187  	u8 off2[QCOM_SDW_MAX_PORTS];
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1188  	u8 si[QCOM_SDW_MAX_PORTS];
5ffba1fb6d55555 Srinivas Kandagatla  2020-09-17  1189  	u8 bp_mode[QCOM_SDW_MAX_PORTS] = { 0, };
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1190  	u8 hstart[QCOM_SDW_MAX_PORTS];
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1191  	u8 hstop[QCOM_SDW_MAX_PORTS];
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1192  	u8 word_length[QCOM_SDW_MAX_PORTS];
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1193  	u8 blk_group_count[QCOM_SDW_MAX_PORTS];
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1194  	u8 lane_control[QCOM_SDW_MAX_PORTS];
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1195  	int i, ret, nports, val;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1196  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1197  	ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1198  
9972b90ae8fd9bc Vinod Koul           2020-09-03  1199  	ctrl->num_dout_ports = FIELD_GET(SWRM_COMP_PARAMS_DOUT_PORTS_MASK, val);
9972b90ae8fd9bc Vinod Koul           2020-09-03  1200  	ctrl->num_din_ports = FIELD_GET(SWRM_COMP_PARAMS_DIN_PORTS_MASK, val);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1201  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1202  	ret = of_property_read_u32(np, "qcom,din-ports", &val);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1203  	if (ret)
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1204  		return ret;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1205  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1206  	if (val > ctrl->num_din_ports)
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1207  		return -EINVAL;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1208  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1209  	ctrl->num_din_ports = val;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1210  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1211  	ret = of_property_read_u32(np, "qcom,dout-ports", &val);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1212  	if (ret)
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1213  		return ret;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1214  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1215  	if (val > ctrl->num_dout_ports)
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1216  		return -EINVAL;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1217  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1218  	ctrl->num_dout_ports = val;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1219  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1220  	nports = ctrl->num_dout_ports + ctrl->num_din_ports;
2367e0ecb498764 Krzysztof Kozlowski  2023-02-22  1221  	if (nports > QCOM_SDW_MAX_PORTS)

nports is capped at 14.

2367e0ecb498764 Krzysztof Kozlowski  2023-02-22  1222  		return -EINVAL;
2367e0ecb498764 Krzysztof Kozlowski  2023-02-22  1223  
650dfdb894f0f2b Srinivas Kandagatla  2021-03-15  1224  	/* Valid port numbers are from 1-14, so mask out port 0 explicitly */
650dfdb894f0f2b Srinivas Kandagatla  2021-03-15  1225  	set_bit(0, &ctrl->dout_port_mask);
650dfdb894f0f2b Srinivas Kandagatla  2021-03-15  1226  	set_bit(0, &ctrl->din_port_mask);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1227  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1228  	ret = of_property_read_u8_array(np, "qcom,ports-offset1",
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1229  					off1, nports);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1230  	if (ret)
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1231  		return ret;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1232  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1233  	ret = of_property_read_u8_array(np, "qcom,ports-offset2",
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1234  					off2, nports);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1235  	if (ret)
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1236  		return ret;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1237  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1238  	ret = of_property_read_u8_array(np, "qcom,ports-sinterval-low",
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1239  					si, nports);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1240  	if (ret)
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1241  		return ret;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1242  
5ffba1fb6d55555 Srinivas Kandagatla  2020-09-17  1243  	ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
5ffba1fb6d55555 Srinivas Kandagatla  2020-09-17  1244  					bp_mode, nports);
da096fbccd52803 Srinivas Kandagatla  2021-05-04  1245  	if (ret) {
208a03ee9db815f Krzysztof Kozlowski  2023-02-22  1246  		if (ctrl->version <= SWRM_VERSION_1_3_0)
da096fbccd52803 Srinivas Kandagatla  2021-05-04  1247  			memset(bp_mode, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
da096fbccd52803 Srinivas Kandagatla  2021-05-04  1248  		else
a5943e4fb14e36d Pierre-Louis Bossart 2021-03-02  1249  			return ret;
da096fbccd52803 Srinivas Kandagatla  2021-05-04  1250  	}
a5943e4fb14e36d Pierre-Louis Bossart 2021-03-02  1251  
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1252  	memset(hstart, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1253  	of_property_read_u8_array(np, "qcom,ports-hstart", hstart, nports);
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1254  
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1255  	memset(hstop, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1256  	of_property_read_u8_array(np, "qcom,ports-hstop", hstop, nports);
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1257  
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1258  	memset(word_length, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1259  	of_property_read_u8_array(np, "qcom,ports-word-length", word_length, nports);
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1260  
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1261  	memset(blk_group_count, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1262  	of_property_read_u8_array(np, "qcom,ports-block-group-count", blk_group_count, nports);
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1263  
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1264  	memset(lane_control, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1265  	of_property_read_u8_array(np, "qcom,ports-lane-control", lane_control, nports);
128eaf937adb87a Srinivas Kandagatla  2021-03-30  1266  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1267  	for (i = 0; i < nports; i++) {
9916c02ccd74e67 Srinivas Kandagatla  2021-04-01  1268  		/* Valid port number range is from 1-14 */
9916c02ccd74e67 Srinivas Kandagatla  2021-04-01 @1269  		ctrl->pconfig[i + 1].si = si[i];

But this is doing i + 1 so it's one past the end.

9916c02ccd74e67 Srinivas Kandagatla  2021-04-01  1270  		ctrl->pconfig[i + 1].off1 = off1[i];
9916c02ccd74e67 Srinivas Kandagatla  2021-04-01  1271  		ctrl->pconfig[i + 1].off2 = off2[i];
9916c02ccd74e67 Srinivas Kandagatla  2021-04-01  1272  		ctrl->pconfig[i + 1].bp_mode = bp_mode[i];
9916c02ccd74e67 Srinivas Kandagatla  2021-04-01  1273  		ctrl->pconfig[i + 1].hstart = hstart[i];
9916c02ccd74e67 Srinivas Kandagatla  2021-04-01  1274  		ctrl->pconfig[i + 1].hstop = hstop[i];
9916c02ccd74e67 Srinivas Kandagatla  2021-04-01  1275  		ctrl->pconfig[i + 1].word_length = word_length[i];
9916c02ccd74e67 Srinivas Kandagatla  2021-04-01  1276  		ctrl->pconfig[i + 1].blk_group_count = blk_group_count[i];
9916c02ccd74e67 Srinivas Kandagatla  2021-04-01  1277  		ctrl->pconfig[i + 1].lane_control = lane_control[i];
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1278  	}
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1279  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1280  	return 0;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  1281  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

