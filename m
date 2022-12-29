Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1121658E56
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiL2PbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiL2PbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:31:14 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBC3262F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:31:12 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bk16so4479113wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZK/EtjpVX3hCjCN8ksIwZp8RJuM8+9aHiQlPBaLZdk=;
        b=TvCmpecZ7VMB0bh8Nu9D4Xlem3b5GRj+wGJQfCMCw6fKa/loBmAimU86Pj7jYOq7YI
         ejRnlotOuLvc1MovU+rfifLHtDrGwy4fNlacNB30RVKxk7Jdr6cmJMnE/ez0Hqfj1DwK
         gjahxY2YjX0BI8JYoikFcnuJ5X3HdnGkKE6S3ohmGiuMU/69Jkgcli/SHx00wpSNn7IS
         sYIN3BlATRnsZBaAsyZ0tewDfYUzM5FmArcmaOMgY4wXefbvLqYSzImVxNKghUQeaBik
         dEvbh++kGdyrmH5D2ki4FXUl24RF99dZRE2KBmSxhuyoyShUvrJt63HA+iTex3DD2Du0
         r3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZK/EtjpVX3hCjCN8ksIwZp8RJuM8+9aHiQlPBaLZdk=;
        b=hhlajo2Df+WwIONT6Ih5D/XqqJFib4DpFo8Cy7ptsENKVFGxCGXJOXwGYoCVMl/hCd
         oZH0bw3umHSvT8V0d7Rl6FDq/5Ug6WtPzgXAIROv3/13r5AD9LHMGTqy+NmQrgCV2DuF
         m8juif3Gt0kx2GRhbY+kHjpUYYyNWf4fGqaJR4M1A+KYWtTWFhoGVVUacTN0hjMPwpux
         Pfnl5P/cDJdJoh/pvg7uZN4kNqRMwPkCPrUpSNDUzQqwWMa+SB02DFmHgVzLIgAicTqE
         qws64LT+hGRJSLoIfLY0Ta6+25bdlabQZfBmDuh5nw9gmpAofMihAyNwJsKwlokRzq1R
         DKIQ==
X-Gm-Message-State: AFqh2kr/RXnzsewKBvuJNLXHTEAHxjihArs2spg5/9a4Tu4zSoL1xBca
        j/v3DdelCvalfbDWpZ8K6fg=
X-Google-Smtp-Source: AMrXdXvmtyCCuQ5LIavjdDf5Vmai59voqUABHcnR4aLLZmj3TbhRCqUYV/Gf+MfcLhFYVj9mRTBkdA==
X-Received: by 2002:a5d:4587:0:b0:27f:a81:b819 with SMTP id p7-20020a5d4587000000b0027f0a81b819mr10184044wrq.22.1672327871312;
        Thu, 29 Dec 2022 07:31:11 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o6-20020adfa106000000b002423620d356sm18707061wro.35.2022.12.29.07.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:31:10 -0800 (PST)
Date:   Thu, 29 Dec 2022 18:31:07 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Subject: drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c:161
 amd_sfh1_1_hid_client_init() warn: missing unwind goto?
Message-ID: <202212292225.Y36er6dX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1b929c02afd37871d5afb9d498426f83432e71c2
commit: 93ce5e0231d79189be4d9e5f9295807b18941419 HID: amd_sfh: Implement SFH1.1 functionality
config: ia64-randconfig-m041-20221229
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c:161 amd_sfh1_1_hid_client_init() warn: missing unwind goto?

vim +161 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c

93ce5e0231d791 Basavaraj Natikar 2022-07-12   95  static int amd_sfh1_1_hid_client_init(struct amd_mp2_dev *privdata)
93ce5e0231d791 Basavaraj Natikar 2022-07-12   96  {
93ce5e0231d791 Basavaraj Natikar 2022-07-12   97  	struct amd_input_data *in_data = &privdata->in_data;
93ce5e0231d791 Basavaraj Natikar 2022-07-12   98  	struct amdtp_cl_data *cl_data = privdata->cl_data;
93ce5e0231d791 Basavaraj Natikar 2022-07-12   99  	struct amd_mp2_ops *mp2_ops = privdata->mp2_ops;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  100  	struct amd_mp2_sensor_info info;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  101  	struct request_list *req_list;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  102  	u32 feature_report_size;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  103  	u32 input_report_size;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  104  	struct device *dev;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  105  	int rc, i, status;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  106  	u8 cl_idx;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  107  
93ce5e0231d791 Basavaraj Natikar 2022-07-12  108  	req_list = &cl_data->req_list;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  109  	dev = &privdata->pdev->dev;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  110  	amd_sfh1_1_set_desc_ops(mp2_ops);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  111  
93ce5e0231d791 Basavaraj Natikar 2022-07-12  112  	cl_data->num_hid_devices = amd_sfh_get_sensor_num(privdata, &cl_data->sensor_idx[0]);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  113  
93ce5e0231d791 Basavaraj Natikar 2022-07-12  114  	INIT_DELAYED_WORK(&cl_data->work, amd_sfh_work);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  115  	INIT_DELAYED_WORK(&cl_data->work_buffer, amd_sfh_work_buffer);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  116  	INIT_LIST_HEAD(&req_list->list);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  117  	cl_data->in_data = in_data;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  118  
93ce5e0231d791 Basavaraj Natikar 2022-07-12  119  	for (i = 0; i < cl_data->num_hid_devices; i++) {
93ce5e0231d791 Basavaraj Natikar 2022-07-12  120  		cl_data->sensor_sts[i] = SENSOR_DISABLED;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  121  		cl_data->sensor_requested_cnt[i] = 0;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  122  		cl_data->cur_hid_dev = i;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  123  		cl_idx = cl_data->sensor_idx[i];
93ce5e0231d791 Basavaraj Natikar 2022-07-12  124  
93ce5e0231d791 Basavaraj Natikar 2022-07-12  125  		cl_data->report_descr_sz[i] = mp2_ops->get_desc_sz(cl_idx, descr_size);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  126  		if (!cl_data->report_descr_sz[i]) {
93ce5e0231d791 Basavaraj Natikar 2022-07-12  127  			rc = -EINVAL;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  128  			goto cleanup;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  129  		}
93ce5e0231d791 Basavaraj Natikar 2022-07-12  130  		feature_report_size = mp2_ops->get_desc_sz(cl_idx, feature_size);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  131  		if (!feature_report_size) {
93ce5e0231d791 Basavaraj Natikar 2022-07-12  132  			rc = -EINVAL;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  133  			goto cleanup;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  134  		}
93ce5e0231d791 Basavaraj Natikar 2022-07-12  135  		input_report_size =  mp2_ops->get_desc_sz(cl_idx, input_size);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  136  		if (!input_report_size) {
93ce5e0231d791 Basavaraj Natikar 2022-07-12  137  			rc = -EINVAL;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  138  			goto cleanup;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  139  		}
93ce5e0231d791 Basavaraj Natikar 2022-07-12  140  		cl_data->feature_report[i] = devm_kzalloc(dev, feature_report_size, GFP_KERNEL);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  141  		if (!cl_data->feature_report[i]) {
93ce5e0231d791 Basavaraj Natikar 2022-07-12  142  			rc = -ENOMEM;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  143  			goto cleanup;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  144  		}
93ce5e0231d791 Basavaraj Natikar 2022-07-12  145  		in_data->input_report[i] = devm_kzalloc(dev, input_report_size, GFP_KERNEL);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  146  		if (!in_data->input_report[i]) {
93ce5e0231d791 Basavaraj Natikar 2022-07-12  147  			rc = -ENOMEM;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  148  			goto cleanup;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  149  		}
93ce5e0231d791 Basavaraj Natikar 2022-07-12  150  
93ce5e0231d791 Basavaraj Natikar 2022-07-12  151  		info.sensor_idx = cl_idx;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  152  
93ce5e0231d791 Basavaraj Natikar 2022-07-12  153  		cl_data->report_descr[i] =
93ce5e0231d791 Basavaraj Natikar 2022-07-12  154  			devm_kzalloc(dev, cl_data->report_descr_sz[i], GFP_KERNEL);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  155  		if (!cl_data->report_descr[i]) {
93ce5e0231d791 Basavaraj Natikar 2022-07-12  156  			rc = -ENOMEM;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  157  			goto cleanup;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  158  		}
93ce5e0231d791 Basavaraj Natikar 2022-07-12  159  		rc = mp2_ops->get_rep_desc(cl_idx, cl_data->report_descr[i]);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  160  		if (rc)
93ce5e0231d791 Basavaraj Natikar 2022-07-12 @161  			return rc;

goto cleanup?

93ce5e0231d791 Basavaraj Natikar 2022-07-12  162  
93ce5e0231d791 Basavaraj Natikar 2022-07-12  163  		writel(0, privdata->mmio + AMD_P2C_MSG(0));
93ce5e0231d791 Basavaraj Natikar 2022-07-12  164  		mp2_ops->start(privdata, info);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  165  		status = amd_sfh_wait_for_response
93ce5e0231d791 Basavaraj Natikar 2022-07-12  166  				(privdata, cl_data->sensor_idx[i], ENABLE_SENSOR);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  167  
93ce5e0231d791 Basavaraj Natikar 2022-07-12  168  		status = (status == 0) ? SENSOR_ENABLED : SENSOR_DISABLED;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  169  
93ce5e0231d791 Basavaraj Natikar 2022-07-12  170  		if (status == SENSOR_ENABLED) {
93ce5e0231d791 Basavaraj Natikar 2022-07-12  171  			cl_data->sensor_sts[i] = SENSOR_ENABLED;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  172  			rc = amdtp_hid_probe(i, cl_data);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  173  			if (rc) {
93ce5e0231d791 Basavaraj Natikar 2022-07-12  174  				mp2_ops->stop(privdata, cl_data->sensor_idx[i]);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  175  				status = amd_sfh_wait_for_response
93ce5e0231d791 Basavaraj Natikar 2022-07-12  176  					(privdata, cl_data->sensor_idx[i], DISABLE_SENSOR);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  177  				if (status == 0)
93ce5e0231d791 Basavaraj Natikar 2022-07-12  178  					status = SENSOR_DISABLED;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  179  				if (status != SENSOR_ENABLED)
93ce5e0231d791 Basavaraj Natikar 2022-07-12  180  					cl_data->sensor_sts[i] = SENSOR_DISABLED;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  181  				dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
93ce5e0231d791 Basavaraj Natikar 2022-07-12  182  					cl_data->sensor_idx[i],
93ce5e0231d791 Basavaraj Natikar 2022-07-12  183  					get_sensor_name(cl_data->sensor_idx[i]),
93ce5e0231d791 Basavaraj Natikar 2022-07-12  184  					cl_data->sensor_sts[i]);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  185  				goto cleanup;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  186  			}
93ce5e0231d791 Basavaraj Natikar 2022-07-12  187  		}
93ce5e0231d791 Basavaraj Natikar 2022-07-12  188  		dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
93ce5e0231d791 Basavaraj Natikar 2022-07-12  189  			cl_data->sensor_idx[i], get_sensor_name(cl_data->sensor_idx[i]),
93ce5e0231d791 Basavaraj Natikar 2022-07-12  190  			cl_data->sensor_sts[i]);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  191  	}
93ce5e0231d791 Basavaraj Natikar 2022-07-12  192  
93ce5e0231d791 Basavaraj Natikar 2022-07-12  193  	schedule_delayed_work(&cl_data->work_buffer, msecs_to_jiffies(AMD_SFH_IDLE_LOOP));
93ce5e0231d791 Basavaraj Natikar 2022-07-12  194  	return 0;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  195  
93ce5e0231d791 Basavaraj Natikar 2022-07-12  196  cleanup:
93ce5e0231d791 Basavaraj Natikar 2022-07-12  197  	amd_sfh_hid_client_deinit(privdata);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  198  	for (i = 0; i < cl_data->num_hid_devices; i++) {
93ce5e0231d791 Basavaraj Natikar 2022-07-12  199  		devm_kfree(dev, cl_data->feature_report[i]);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  200  		devm_kfree(dev, in_data->input_report[i]);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  201  		devm_kfree(dev, cl_data->report_descr[i]);
93ce5e0231d791 Basavaraj Natikar 2022-07-12  202  	}
93ce5e0231d791 Basavaraj Natikar 2022-07-12  203  	return rc;
93ce5e0231d791 Basavaraj Natikar 2022-07-12  204  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

