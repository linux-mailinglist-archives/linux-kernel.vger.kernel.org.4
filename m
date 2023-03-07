Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE2F6AD712
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCGGBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCGGBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:01:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98CC4DE30;
        Mon,  6 Mar 2023 22:01:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68C99611B6;
        Tue,  7 Mar 2023 06:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C92C433EF;
        Tue,  7 Mar 2023 06:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678168900;
        bh=xlQv5ZF9uz5qXAhO/3nR4xFyeMK6zkkCXsLp/a3Z1fA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=BAli/Vbb+GkkidkJGK7WwwLI7F+q6UAQ/W3ixqtkcUb+DtQz0IyAnW9zd2T3AI/DN
         BuFd4vvufnyWOGbNTBFiZEKOdbOtD/CHc+qH9hJBXRGYbVWgCkt8E4Yj7H5Utzl0W9
         2CFdHG5VLmCsRk69St/DasRzDuohzoomUgD8/pY49UDW7njvrwWNd9iynwMuYzx/Lv
         kvCHPhRwzd4Uz3ZzSP2UxDQNH0vQf2+ch1yCSF7xxwNkcAspjlIBTP8YYIcSX2XS8w
         lm6Z5sdnXHREYs8r5AcYTjTlc+WVkzEWAafeBGyMsoTCag1RBnXTbu1V0wYYkGHYky
         gMAtL3CtApKnw==
Message-ID: <fa4cfb68-5866-ecea-4073-4c5c52e587c9@kernel.org>
Date:   Tue, 7 Mar 2023 14:01:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] f2fs: Fix f2fs_truncate_partial_nodes ftrace event
Content-Language: en-US
To:     Douglas RAILLARD <douglas.raillard@arm.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <20230306122549.236561-1-douglas.raillard@arm.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230306122549.236561-1-douglas.raillard@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/6 20:25, Douglas RAILLARD wrote:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Fix the nid_t field so that its size is correctly reported in the text
> format embedded in trace.dat files. As it stands, it is reported as
> being of size 4:
> 
>          field:nid_t nid[3];     offset:24;      size:4; signed:0;
> 
> Instead of 12:
> 
>          field:nid_t nid[3];     offset:24;      size:12;        signed:0;
> 
> This also fixes the reported offset of subsequent fields so that they
> match with the actual struct layout.
> 
> 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
