Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37FB660D0E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 09:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjAGIpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 03:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAGIpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 03:45:47 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F41861445
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 00:45:46 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso2600128wmp.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 00:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lt9W0zTmSfnJ2L+6b3nzdRY70GeMsclpC2RCJP1f6Oc=;
        b=o1dHo9I7Mg7cY2PH33Rv0uczDOpn/IfMYwEF51AMsebUkm6u/S5FX9ul/D7voM0k/N
         eKS+hjzDcLaN4+WNAjAANp2+lodYsC4hBnMFs3kImwpoNwKFzeiF3S0VSqBCLXg1jF+d
         r04Lb6Ei5Rhn6D4AfJIh8BPiYoWCJUTyD8mUXIIU4y1pq7+2bV8WmZ6W52CxY27czXdn
         lYy0USwSVJb7gJIjVEmbtzWNO/C9CKnetYVe0W65X/Bs/DNzuxRCUJ35Hsd2DZg7xjrk
         TGR8n7QztAEJFCaZjafgrS7TPA5bnXu921v8lfevP17hW11ZP/Mi5YqxPm5dUXveiO8w
         mlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lt9W0zTmSfnJ2L+6b3nzdRY70GeMsclpC2RCJP1f6Oc=;
        b=i3k8+2TPZGFKKaB9usUK0mH03Eok1CttYtluuzLTqxg26EMTQ/EKuzTiXDmLEaesqA
         uyQeb44gcu9EYwK9XHUvLJif3Rh0v6jSjuc9UHQwlZLAFMmP1vaFEyAwNP1jqVDYgprx
         UsIT/7XV8KqhVB/cK4UH8S+ktczVbHJkych/wLq1EdaSj+F1tWSShzeXXNOCnULQBYlF
         VHntBKtS9klhaNNbsXFDiKXR0EKtJw/njVT23niz/Vd+l1wZ/k5p02nreCUT9RvNgZV2
         rRoRwvTTIfbZzaOA9c9Yymr5UHf5GkLRe18NSGvwt+E9N+qrWi9lONMcf8wUf3EkwecT
         JM6Q==
X-Gm-Message-State: AFqh2kpAHYR5sDzz8mYKBR1yjA587BMKiYyz3dbu9tnHv9x+eIB2Y7Xr
        DRFBOL6wuN6rW9aIwi6Z+QCZPRd1tBCmVb+Q
X-Google-Smtp-Source: AMrXdXvsQtGXFJhQfrrkI4KgBRY4dHbLotWADHTfRdRUkZs9u76mJuVMer8RobFSGwcS+je1KPj/Ow==
X-Received: by 2002:a05:600c:3b2a:b0:3d9:7950:dc6d with SMTP id m42-20020a05600c3b2a00b003d97950dc6dmr31010228wms.40.1673081145145;
        Sat, 07 Jan 2023 00:45:45 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c4fcb00b003c6f3f6675bsm9855943wmq.26.2023.01.07.00.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 00:45:44 -0800 (PST)
Date:   Sat, 7 Jan 2023 11:45:39 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c:275
 vcap_show_admin() warn: passing zero to 'PTR_ERR'
Message-ID: <202301071222.ef1ERM6s-lkp@intel.com>
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
head:   0a71553536d270e988580a3daa9fc87535908221
commit: 610c32b2ce66d4aaa07b3a77a709bd4d2b268bb1 net: microchip: vcap: Add vcap_get_rule
config: arc-randconfig-m041-20230106
compiler: arc-elf-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c:275 vcap_show_admin() warn: passing zero to 'PTR_ERR'

Old smatch warnings:
drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c:103 vcap_debugfs_show_rule_keyfield() error: uninitialized symbol 'value'.
drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c:106 vcap_debugfs_show_rule_keyfield() error: uninitialized symbol 'mask'.

vim +/PTR_ERR +275 drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c

3a7921560d2fd3 Steen Hegelund 2022-11-17  263  static int vcap_show_admin(struct vcap_control *vctrl,
3a7921560d2fd3 Steen Hegelund 2022-11-17  264  			   struct vcap_admin *admin,
3a7921560d2fd3 Steen Hegelund 2022-11-17  265  			   struct vcap_output_print *out)
3a7921560d2fd3 Steen Hegelund 2022-11-17  266  {
610c32b2ce66d4 Horatiu Vultur 2022-12-03  267  	struct vcap_rule_internal *elem;
610c32b2ce66d4 Horatiu Vultur 2022-12-03  268  	struct vcap_rule *vrule;
3a7921560d2fd3 Steen Hegelund 2022-11-17  269  	int ret = 0;
3a7921560d2fd3 Steen Hegelund 2022-11-17  270  
3a7921560d2fd3 Steen Hegelund 2022-11-17  271  	vcap_show_admin_info(vctrl, admin, out);
3a7921560d2fd3 Steen Hegelund 2022-11-17  272  	list_for_each_entry(elem, &admin->rules, list) {
610c32b2ce66d4 Horatiu Vultur 2022-12-03  273  		vrule = vcap_get_rule(vctrl, elem->data.id);
610c32b2ce66d4 Horatiu Vultur 2022-12-03  274  		if (IS_ERR_OR_NULL(vrule)) {
610c32b2ce66d4 Horatiu Vultur 2022-12-03 @275  			ret = PTR_ERR(vrule);

This isn't right.  The error pointer and the NULL should be handled
differently.  I haven't looked at vcap_get_rule() but if it really
returns both then it should be something like:

	vrule = vcap_get_rule(vctrl, elem->data.id);
	if (IS_ERR(vrule))
		return PTR_ERR(vrule);
	if (!vrule)
		continue;

610c32b2ce66d4 Horatiu Vultur 2022-12-03  276  			break;
682f560b8a87bf Dan Carpenter  2022-11-29  277  		}
610c32b2ce66d4 Horatiu Vultur 2022-12-03  278  
3a7921560d2fd3 Steen Hegelund 2022-11-17  279  		out->prf(out->dst, "\n");
610c32b2ce66d4 Horatiu Vultur 2022-12-03  280  		vcap_show_admin_rule(vctrl, admin, out, to_intrule(vrule));
610c32b2ce66d4 Horatiu Vultur 2022-12-03  281  		vcap_free_rule(vrule);
3a7921560d2fd3 Steen Hegelund 2022-11-17  282  	}
3a7921560d2fd3 Steen Hegelund 2022-11-17  283  	return ret;
3a7921560d2fd3 Steen Hegelund 2022-11-17  284  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

