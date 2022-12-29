Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD302658DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiL2Num (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiL2Nuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:50:39 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320D61EA;
        Thu, 29 Dec 2022 05:50:38 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o15so13137142wmr.4;
        Thu, 29 Dec 2022 05:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=duyEJD1qg+3LQJyuFvYZow64sOCy88nxykalmK5O5YU=;
        b=DC8n2ULg36RcVmSYx50CJMQ0eKjA+XqWSbxmNNQddQPw+y9jGuqMJ5bSMLhE3wWw2l
         dJ2X9J1UwT9HegH6ldg4b5+Obboc0CtWWjA5Wdd5Cw7aXR0o+tDcpBH4YXabdnlgWHd8
         B4WjwxV2ChiLz6RTDIIOBU38djnNzOTb+f2rdu7fqheO4Vw5uxcmIxPCiAWwKxv0DPtv
         67vz7MExxkSIZZiRKAf9SjVDv1NHtlMg5I0QNEkoZzgR7aIp8L96S5M8U3MzNpLamQoH
         NYzlH9UABH4e7N6JKbFmyaobUvMgLY+Ev+EKa2Xw1u8E+TOwexJTTWsG+Tpu6KCBTPMp
         s8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duyEJD1qg+3LQJyuFvYZow64sOCy88nxykalmK5O5YU=;
        b=2Trw2U0iHrtqI7cPlSi5aI0bu30pQD1JjLlE6f6wxmMIYpyZrNZLTlUKLLo+oZKJwr
         SaJpoVbOB0YosWPzdlewLcBdSHOsmkwiS0jwyWcE1oaER7wHzEJ86gp/C5vkcZwS/BQx
         x64psjn6cJtYYzEAWHkICUgVLaN9RUpF972eBn7EbkOJZ0fA5bNMxl6PGIng4+hMTdOJ
         SVIYpJp9xQytd0w6GQjKrfw08/qVtzGBfMTEufZpJNm8cvhkI6OWLWBRfNoXlFLZKJP8
         0PG+7wUO+c0X/o6ciNpGbu2iPiX66+Y5Qt9mXAqoFp+fl7cKY0q4b9na20xqgg9S6IPr
         IReg==
X-Gm-Message-State: AFqh2krXyRS0KZCPDjynC+KBoOtahSB+FnbmeiyQYV61lVFJhKcc1le3
        SJNRAVvSWEtxJVWYEA3UW8T8Jt4Pj5Bbpil1
X-Google-Smtp-Source: AMrXdXsejk/XMwVhyDlX8eDlbR3H9pClUTd3eb8SV8HIMnlFVXHwnRl+nWjcGCr1FNcJ5hGZnloybQ==
X-Received: by 2002:a05:600c:512a:b0:3d3:3c60:b2bb with SMTP id o42-20020a05600c512a00b003d33c60b2bbmr20372131wms.23.1672321836534;
        Thu, 29 Dec 2022 05:50:36 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c19c900b003d9876aa04asm14969441wmq.41.2022.12.29.05.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 05:50:36 -0800 (PST)
Date:   Thu, 29 Dec 2022 16:50:33 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: drivers/media/v4l2-core/v4l2-ctrls-api.c:152 user_to_new() warn: if
 statement not indented
Message-ID: <202212291913.3PNcavtH-lkp@intel.com>
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
commit: 73278d483378cf850ade923a1107a70297b2602a media: v4l2-ctrls-api.c: add back dropped ctrl->is_new = 1
config: sh-randconfig-m031-20221228
compiler: sh4-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/media/v4l2-core/v4l2-ctrls-api.c:152 user_to_new() warn: if statement not indented
drivers/media/v4l2-core/v4l2-ctrls-api.c:154 user_to_new() warn: inconsistent indenting

vim +152 drivers/media/v4l2-core/v4l2-ctrls-api.c

fb582cba44928f Hans Verkuil 2022-07-08   98  static int user_to_new(struct v4l2_ext_control *c, struct v4l2_ctrl *ctrl)
71c689dc2e732d Hans Verkuil 2021-04-27   99  {
71c689dc2e732d Hans Verkuil 2021-04-27  100  	int ret;
71c689dc2e732d Hans Verkuil 2021-04-27  101  	u32 size;
71c689dc2e732d Hans Verkuil 2021-04-27  102  
fb582cba44928f Hans Verkuil 2022-07-08  103  	ctrl->is_new = 0;
fb582cba44928f Hans Verkuil 2022-07-08  104  	if (ctrl->is_dyn_array &&
5f2c5c69a61dc5 Hans Verkuil 2022-07-11  105  	    c->size > ctrl->p_array_alloc_elems * ctrl->elem_size) {
5f2c5c69a61dc5 Hans Verkuil 2022-07-11  106  		void *old = ctrl->p_array;
fb582cba44928f Hans Verkuil 2022-07-08  107  		void *tmp = kvzalloc(2 * c->size, GFP_KERNEL);
fb582cba44928f Hans Verkuil 2022-07-08  108  
fb582cba44928f Hans Verkuil 2022-07-08  109  		if (!tmp)
fb582cba44928f Hans Verkuil 2022-07-08  110  			return -ENOMEM;
fb582cba44928f Hans Verkuil 2022-07-08  111  		memcpy(tmp, ctrl->p_new.p, ctrl->elems * ctrl->elem_size);
fb582cba44928f Hans Verkuil 2022-07-08  112  		memcpy(tmp + c->size, ctrl->p_cur.p, ctrl->elems * ctrl->elem_size);
fb582cba44928f Hans Verkuil 2022-07-08  113  		ctrl->p_new.p = tmp;
fb582cba44928f Hans Verkuil 2022-07-08  114  		ctrl->p_cur.p = tmp + c->size;
5f2c5c69a61dc5 Hans Verkuil 2022-07-11  115  		ctrl->p_array = tmp;
5f2c5c69a61dc5 Hans Verkuil 2022-07-11  116  		ctrl->p_array_alloc_elems = c->size / ctrl->elem_size;
fb582cba44928f Hans Verkuil 2022-07-08  117  		kvfree(old);
fb582cba44928f Hans Verkuil 2022-07-08  118  	}
fb582cba44928f Hans Verkuil 2022-07-08  119  
71c689dc2e732d Hans Verkuil 2021-04-27  120  	if (ctrl->is_ptr && !ctrl->is_string) {
fb582cba44928f Hans Verkuil 2022-07-08  121  		unsigned int elems = c->size / ctrl->elem_size;
71c689dc2e732d Hans Verkuil 2021-04-27  122  
fb582cba44928f Hans Verkuil 2022-07-08  123  		if (copy_from_user(ctrl->p_new.p, c->ptr, c->size))
fb582cba44928f Hans Verkuil 2022-07-08  124  			return -EFAULT;
fb582cba44928f Hans Verkuil 2022-07-08  125  		ctrl->is_new = 1;
fb582cba44928f Hans Verkuil 2022-07-08  126  		if (ctrl->is_dyn_array)
fb582cba44928f Hans Verkuil 2022-07-08  127  			ctrl->new_elems = elems;
fb582cba44928f Hans Verkuil 2022-07-08  128  		else if (ctrl->is_array)
cd75981ec93a3a Hans Verkuil 2022-08-29  129  			ctrl->type_ops->init(ctrl, elems, ctrl->p_new);
71c689dc2e732d Hans Verkuil 2021-04-27  130  		return 0;
71c689dc2e732d Hans Verkuil 2021-04-27  131  	}
71c689dc2e732d Hans Verkuil 2021-04-27  132  
71c689dc2e732d Hans Verkuil 2021-04-27  133  	switch (ctrl->type) {
71c689dc2e732d Hans Verkuil 2021-04-27  134  	case V4L2_CTRL_TYPE_INTEGER64:
fb582cba44928f Hans Verkuil 2022-07-08  135  		*ctrl->p_new.p_s64 = c->value64;
71c689dc2e732d Hans Verkuil 2021-04-27  136  		break;
71c689dc2e732d Hans Verkuil 2021-04-27  137  	case V4L2_CTRL_TYPE_STRING:
71c689dc2e732d Hans Verkuil 2021-04-27  138  		size = c->size;
71c689dc2e732d Hans Verkuil 2021-04-27  139  		if (size == 0)
71c689dc2e732d Hans Verkuil 2021-04-27  140  			return -ERANGE;
71c689dc2e732d Hans Verkuil 2021-04-27  141  		if (size > ctrl->maximum + 1)
71c689dc2e732d Hans Verkuil 2021-04-27  142  			size = ctrl->maximum + 1;
fb582cba44928f Hans Verkuil 2022-07-08  143  		ret = copy_from_user(ctrl->p_new.p_char, c->string, size) ? -EFAULT : 0;
71c689dc2e732d Hans Verkuil 2021-04-27  144  		if (!ret) {
fb582cba44928f Hans Verkuil 2022-07-08  145  			char last = ctrl->p_new.p_char[size - 1];
71c689dc2e732d Hans Verkuil 2021-04-27  146  
fb582cba44928f Hans Verkuil 2022-07-08  147  			ctrl->p_new.p_char[size - 1] = 0;
71c689dc2e732d Hans Verkuil 2021-04-27  148  			/*
71c689dc2e732d Hans Verkuil 2021-04-27  149  			 * If the string was longer than ctrl->maximum,
71c689dc2e732d Hans Verkuil 2021-04-27  150  			 * then return an error.
71c689dc2e732d Hans Verkuil 2021-04-27  151  			 */
fb582cba44928f Hans Verkuil 2022-07-08 @152  			if (strlen(ctrl->p_new.p_char) == ctrl->maximum && last)
73278d483378cf Hans Verkuil 2022-12-12  153  			ctrl->is_new = 1;

Was "ctrl->is_new = 1;" supposed to go before the if statement?

71c689dc2e732d Hans Verkuil 2021-04-27 @154  				return -ERANGE;
71c689dc2e732d Hans Verkuil 2021-04-27  155  		}
71c689dc2e732d Hans Verkuil 2021-04-27  156  		return ret;
71c689dc2e732d Hans Verkuil 2021-04-27  157  	default:
fb582cba44928f Hans Verkuil 2022-07-08  158  		*ctrl->p_new.p_s32 = c->value;
71c689dc2e732d Hans Verkuil 2021-04-27  159  		break;
71c689dc2e732d Hans Verkuil 2021-04-27  160  	}
fb582cba44928f Hans Verkuil 2022-07-08  161  	ctrl->is_new = 1;
71c689dc2e732d Hans Verkuil 2021-04-27  162  	return 0;
71c689dc2e732d Hans Verkuil 2021-04-27  163  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

