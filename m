Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E075263B0D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiK1SMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbiK1SMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:12:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6932FC30
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:55:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0BC3B80D1A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E810C433C1;
        Mon, 28 Nov 2022 17:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669658043;
        bh=PNyyGskXEL6J2fr0axt60kXMvnypsmn7KyeoTEQji0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A8Se4BYjG+/aU9nCM1LkdL9QcghZZiVXfO0laO+j5HnxZx3D+I7Kfc/knAfzsuL5b
         F5LRk5RgnItSJscgHgo8jlK6eJxql0guKE0kazvVcOuktAP5AjbwkbM8BNl5z/Jm7E
         Qel8OnxNx7ry8DjUhuHrmBK60exrHDYfvTatRZPa3iE7LirnsF07Svu4YFqZh2Nr1D
         wylafqKmOIQBUzoIwzRrWjEJBA16baopqnE4+dbyvPndRG5Wh3yDGnRmZEVUiZ/vlb
         kxjU4I/XnNwjvhR2IfFemKqAAi5maQcHIHcsjSTfr5a6QwseYlJbtxdoewxg6Z1Tnz
         ZnKeVXN9OF3nQ==
From:   SeongJae Park <sj@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [sj:damon/next 27/34] mm/damon/sysfs-schemes.c:1409:19: error: incomplete definition of type 'struct mem_cgroup'
Date:   Mon, 28 Nov 2022 17:54:01 +0000
Message-Id: <20221128175401.17332-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202211281158.AsAWEmu1-lkp@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Robot,

On Mon, 28 Nov 2022 12:00:58 +0800 kernel test robot <lkp@intel.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 1995 bytes --]
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   c68bc40dc2022ce015ee828d0fccb34f864934f8
> commit: 80bd927ee54ff864d9a6ceb1c6ce4803b22e7220 [27/34] mm/damon/sysfs-schemes: implement scheme filters
> config: x86_64-randconfig-r015-20221128
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/commit/?id=80bd927ee54ff864d9a6ceb1c6ce4803b22e7220
>         git remote add sj https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git
>         git fetch --no-tags sj damon/next
>         git checkout 80bd927ee54ff864d9a6ceb1c6ce4803b22e7220
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> mm/damon/sysfs-schemes.c:1409:19: error: incomplete definition of type 'struct mem_cgroup'
>            cgroup_path(memcg->css.cgroup, memcg_path_buf, PATH_MAX);
>                        ~~~~~^
>    include/linux/mm_types.h:33:8: note: forward declaration of 'struct mem_cgroup'
>    struct mem_cgroup;
>           ^
>    1 error generated.
> 
> 
> vim +1409 mm/damon/sysfs-schemes.c
> 
>   1404	
>   1405	static bool damon_sysfs_memcg_path_eq(struct mem_cgroup *memcg,
>   1406			char *memcg_path_buf, char *path)
>   1407	{
>   1408	#ifdef CONFIG_CGROUPS
> > 1409		cgroup_path(memcg->css.cgroup, memcg_path_buf, PATH_MAX);
>   1410		if (sysfs_streq(memcg_path_buf, path))
>   1411			return true;
>   1412	#endif

'struct mem_cgroup' is defined under '#ifdef CONFIG_MEMCG', so this should be
guarded with it.  Fixed it[1].  Thank you again!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/commit/?h=damon/next&id=dc31f4ababd073e1686de0e51f45c5bbd42e66ac


Thanks,
SJ

>   1413		return false;
>   1414	}
>   1415	
