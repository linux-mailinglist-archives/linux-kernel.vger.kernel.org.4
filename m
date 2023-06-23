Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1671473B0F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 08:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjFWGyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 02:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjFWGyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 02:54:32 -0400
Received: from mail-m11873.qiye.163.com (mail-m11873.qiye.163.com [115.236.118.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D601FF2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 23:54:29 -0700 (PDT)
Received: from [192.168.0.193] (unknown [113.87.232.96])
        by mail-m11873.qiye.163.com (Hmail) with ESMTPA id 903A990044B;
        Fri, 23 Jun 2023 14:54:07 +0800 (CST)
Message-ID: <b4c091e4-945b-3930-9314-5a04ce828e56@sangfor.com.cn>
Date:   Fri, 23 Jun 2023 14:53:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: build warning after merge of the ftrace tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230623143517.19ffc6c0@canb.auug.org.au>
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
In-Reply-To: <20230623143517.19ffc6c0@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHh9DVkMdGkkaT0xPTRgYQ1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKSFVDTFVJSElVQk1ZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a88e70819722eafkusn903a990044b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PE06Hio6Cj1OIgIqKUMILBUK
        E0wKCQtVSlVKTUNMTktISU9DTklDVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpIVUNMVUlISVVCTVlXWQgBWUFKQk1PNwY+
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/23 12:35, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the ftrace tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/trace/ftrace.rst:2797: WARNING: Literal block expected; none found.
> Documentation/trace/ftrace.rst:2816: WARNING: Literal block expected; none found.
> 
> Introduced by commit
> 
>    21c094d3f8a6 ("tracing: Add documentation for funcgraph-retval and funcgraph-retval-hex")
> 

I am so sorry, and I will fix it right now.
