Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66956414EF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 09:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiLCI3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 03:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLCI3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 03:29:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630B4537DD
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 00:29:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q7so11270399wrr.8
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 00:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=++FsqaVqwJx6XYFbJqgrWmLCuJt14qXZ43q8ET3YWf4=;
        b=HhfB9e8o57PE+BDcjO4D+jMa9L2vT2zeY2txxBD+V5LKRTWgFJVzBkl5jHWXj1bCDW
         QVKgDv85lfi2w043G+9Gi25eC0dyUzBLrL5JPfHyfU+e/1pfMR1WONQke/2Q6IraVpLc
         2s9FHnav4wzkVHIdgCN1COw8oCcN2D+05RgdcXi3Nub2a1K9zM9XGoyU/75s7nLCuVJK
         G9nxsa6POuXVHIIRB60+QGpjDv2jxAu7+zDi5qy8y0YIvxQHyphjhC9VKVhabDEybyCo
         lSqFFem87i7NJ9CMH2uRp35qLFqHGYruXb2F2AiVcgdFOW9Q1fgBAO+5VXaGhpNprclJ
         ghLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++FsqaVqwJx6XYFbJqgrWmLCuJt14qXZ43q8ET3YWf4=;
        b=KBH8lyWSONXQjoH6G1mpojUcSsj1zfmGU6adjzWCnZVbQMLYtaQENzKErWkDlMN0zv
         r9CvILOoc6HEIcHrWlMMW8rejqPMCWut1Lxr/2Cg1zm0jzFASfz/VHBx28kh2WeHXlGo
         lyFNwkCsnJBxthqsB3mVjYUi5TWhBD7H/RE3llACCZZJ7fBMmEiHrSLm7D9NQgO4aDXD
         QFAsCZDzrjZRNq83UVyMxcFTfCKHPPnrMbw01KjTMAzmQD4PkujVmeV2wL5fqvzVzPs5
         fZoNGuMBja6kQPgGRwwcMk3NZ49YRtqBUtrW17nBzaJgeVEe3rHSNEiPgnlqschZy60V
         keVw==
X-Gm-Message-State: ANoB5pmga2LccqWZ8XKKz8WMjNt+GovuswgKm6kWHpoZnCo0wbx0nk/h
        EXQBapJ2xxLYE3MFmucgGKA=
X-Google-Smtp-Source: AA0mqf5psme3doI+eE0Qu5GiQ8w8heQyM/BTczlkyI/94oO5q37sIh7C9m/7yqsfMCCRQxuohNF6mA==
X-Received: by 2002:adf:ea4e:0:b0:242:1d48:e043 with SMTP id j14-20020adfea4e000000b002421d48e043mr15623224wrn.498.1670056174834;
        Sat, 03 Dec 2022 00:29:34 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d14-20020adff2ce000000b00241fab5a296sm9025238wrp.40.2022.12.03.00.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 00:29:34 -0800 (PST)
Date:   Sat, 3 Dec 2022 11:29:31 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>, lkp@intel.com
Cc:     oe-kbuild@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: net/mptcp/pm_netlink.c:1169 mptcp_pm_parse_pm_addr_attr() warn:
 missing error code? 'err'
Message-ID: <Y4sI65oadrVtBlnR@kadam>
References: <202212021422.Uh5cCKY2-lkp@intel.com>
 <f0722fd5-af12-4cff-9ffa-38b9e8d23313@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0722fd5-af12-4cff-9ffa-38b9e8d23313@linux.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 03:38:01PM -0800, Mat Martineau wrote:
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1158  	/* no validation needed - was already done via nested policy */
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1159  	err = nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1160  					  mptcp_pm_addr_policy, info->extack);
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1161  	if (err)
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1162  		return err;
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1163
> > 982f17ba1a2534 Florian Westphal 2022-05-03  1164  	if (tb[MPTCP_PM_ADDR_ATTR_ID])
> > 982f17ba1a2534 Florian Westphal 2022-05-03  1165  		addr->id = nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
> > 982f17ba1a2534 Florian Westphal 2022-05-03  1166
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1167  	if (!tb[MPTCP_PM_ADDR_ATTR_FAMILY]) {
> > 01cacb00b35cb6 Paolo Abeni      2020-03-27  1168  		if (!require_family)
> > 982f17ba1a2534 Florian Westphal 2022-05-03 @1169  			return err;
> > 
> > "err" is zero at this point.  Presumably a negative error code was
> > intended.
> 
> Hi Dan -
> 
> The intended error code is 0 here: the return happens if no
> MPTCP_PM_ADDR_ATTR_FAMILY value is present and require_family is false.
> 
> It would be clearer to "return 0;", but the code is working as expected.
> 
> 
> Could you be sure to cc mptcp@lists.linux.dev and
> matthieu.baerts@tessares.net for future MPTCP issues?

These emails are automatically generated by the kbuild team.  I don't
know what kind of heuristics they use...  I've put them on the To
header.  There is probably a reason why they don't just use
get_maintainer.pl...

regards,
dan carpenter

