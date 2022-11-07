Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5E61EC79
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiKGHxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiKGHxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:53:01 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6488F6547
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 23:53:00 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id t4so6320111wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 23:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1EXtR7XJJXiRjK9vYVDqObq6bajFz9XQCg+T26fuKrE=;
        b=AhyPTp2hdxp66jkLu7AniU2AycEFO8kjoA0cTSA2DXMhMakoLktz1BMuwuFBMRoX/L
         iqDcuROIWNrO1ABA1AvPsmmiAQPwvxmCMQF7aNE4VlzVKkbOO1EbgDA6C9m0e1+yann8
         KLNkWVfXds2T/RExpxkwWdWVZM8unzDG437HCPvEiRRHo37+80ifBWPnoaTJV4KVMywv
         AqXyf0MOPklW9RRMqSQvW0Z4wGOHY2DurTzEqyRxSCGagg4TRN+FeNOjsMKqS3V3UiGI
         Ua/VAiTmsxsndtlxlQIdq1zjsdpinmbjos/47b59qPYe+SFpVtfCi0X8Z8MSfMDlD9nH
         VM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EXtR7XJJXiRjK9vYVDqObq6bajFz9XQCg+T26fuKrE=;
        b=EubToqWT41CBjXpxwpmNuD2dHZPbBriAxy6zBa0T+DslF7eeBLQadz8InM/BV0a07m
         yfI4AmxRMi1cOBi1jyHc50OkyPqiIg1xYut/97ClCC6gb2Rfdif4isn7a96q0chyo+i0
         vxXuxl/vNJzS7I2Kr1gRsKsDoXc22HHFSNflkKGzoA1PjgfzRnqReCwb0dMX+b/J2f6p
         jYe7pBhKVcNBo4+5bLdCwkYHCXVCuy2agVjjUnS9TuozLZcKdIElwGiLPMcw8kGfy1pC
         0L2WFN41pvJO8mYTxhAkyt9X1OcfGd21qt4hG+v97zfasHp8f0huh0dKVyYcjJVdxZMW
         Z7Xg==
X-Gm-Message-State: ANoB5plzMMX7TYbIohUElwY9kucYzQzELStFmcSqH1inHGcVIP4Wd7gg
        F5tQWs0BGoyI7AVj4AyuM1Y=
X-Google-Smtp-Source: AA0mqf6U/0XYoOBRltwbquuygrt1XbVmjosVnlfe1s1uJGbaRhSF/xTmhGk6btHBRVs32l434UvZhA==
X-Received: by 2002:a05:600c:1906:b0:3cf:a851:d2b1 with SMTP id j6-20020a05600c190600b003cfa851d2b1mr3825762wmq.18.1667807578922;
        Sun, 06 Nov 2022 23:52:58 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l32-20020a05600c1d2000b003c6b7f5567csm27209809wms.0.2022.11.06.23.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 23:52:58 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:52:55 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     oe-kbuild@lists.linux.dev,
        Heming Zhao via Ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: fs/ocfs2/super.c:1809 ocfs2_mount_volume() warn: missing error
 code 'status'
Message-ID: <Y2i5V0CIH2tOCMUs@kadam>
References: <202211050722.8YGvtPaR-lkp@intel.com>
 <97361840-0a56-f074-0495-712dafe4313d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97361840-0a56-f074-0495-712dafe4313d@linux.alibaba.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 08:38:07PM +0800, Joseph Qi wrote:
> 
> 
> On 11/5/22 7:15 PM, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   10d916c86ecafeccaed89175ebf9b832dddde380
> > commit: 0737e01de9c411e4db87dcedf4a9789d41b1c5c1 ocfs2: ocfs2_mount_volume does cleanup job before return error
> > config: alpha-randconfig-m041-20221030
> > compiler: alpha-linux-gcc (GCC) 12.1.0
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > 
> > smatch warnings:
> > fs/ocfs2/super.c:1809 ocfs2_mount_volume() warn: missing error code 'status'
> > 
> > vim +/status +1809 fs/ocfs2/super.c
> > 
> > ccd979bdbce9fba Mark Fasheh                 2005-12-15  1802  
> > ccd979bdbce9fba Mark Fasheh                 2005-12-15  1803  static int ocfs2_mount_volume(struct super_block *sb)
> > ccd979bdbce9fba Mark Fasheh                 2005-12-15  1804  {
> > ccd979bdbce9fba Mark Fasheh                 2005-12-15  1805  	int status = 0;
> > ccd979bdbce9fba Mark Fasheh                 2005-12-15  1806  	struct ocfs2_super *osb = OCFS2_SB(sb);
> > ccd979bdbce9fba Mark Fasheh                 2005-12-15  1807  
> > ccd979bdbce9fba Mark Fasheh                 2005-12-15  1808  	if (ocfs2_is_hard_readonly(osb))
> > 0737e01de9c411e Heming Zhao via Ocfs2-devel 2022-04-29 @1809  		goto out;
> > 
> > Unclear if this is an error path or a success path.  Honestly, I would
> > have thought the checker is correct that it looks like a failure path.
> > 
> This indicates a readonly mount and bypasses dlm related initialization.
> So it seems an expected success return.
> 

A comment would help.  Another way to silence this static checker warning
and answer any reviewer questions would be to set the "ret = 0;" within
4 lines of the goto.

	if (ocfs2_is_hard_readonly(osb)) {
		status = 0;
		goto out;
	}

regards,
dan carpenter

