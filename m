Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4628972C842
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbjFLOYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237975AbjFLOYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:24:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEB3294D;
        Mon, 12 Jun 2023 07:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E566286F;
        Mon, 12 Jun 2023 14:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5812AC433EF;
        Mon, 12 Jun 2023 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579701;
        bh=bSUbZg2GY9GL7g7yiiN7tqLp1+VLUW4pVV34E8slSwo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lk0U0vNCLXQ1jivG/UTk76PB3arKqpixoHqJxze+Y0oeKQYI25nfxIRv9g7FkYVIx
         F8wVXE0VeX09NSrfb19zCwclIB1bs51uXd/uTAVZonb+t/LhSq76sGtK8vFKgtP4We
         /h7LeE3Fc9ZmBewyd4Onfs/WH29sWmtjrjs/w0Tu+DPUWeQFxlNwA7ZK+UlmpKr2me
         yWkAS+rvrfAnVzak8Iu0biKpUHP7Ea8MI8JeVjIq7DaFzFhjWGNLCQ3bpdWkqcM282
         cBoDHFPDO475XTpOvyhfFO4cQx8W89mA+6fdK8VJCRa9DMgf6PxytEXcQa/evvB8Ai
         tUUHO95sQgenw==
Message-ID: <8cbfa5c1-bc6b-741e-3739-f251edeecfbf@kernel.org>
Date:   Mon, 12 Jun 2023 16:21:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V3 02/11] rtla: Add --house-keeping option
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1686066600.git.bristot@kernel.org>
 <6a6c78a579a96ba8b02ae67ee1e0ba2cb5e03c4a.1686066600.git.bristot@kernel.org>
 <20230612230600.7e009782e8365cd5f1bce444@kernel.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230612230600.7e009782e8365cd5f1bce444@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 16:06, Masami Hiramatsu (Google) wrote:
> On Tue,  6 Jun 2023 18:12:16 +0200
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> To avoid having rtla interfering with the measurement threads, add an
>> option for the user to set the CPUs in which rtla should run. For
>> instance:
>>
>>   # rtla timerlat top -H 0 -C 1-7
> Isn't it '-c 1-7' instead of '-C', because -C is for cgroup name?

Ooops, you are right.

-- Daniel

> Thanks,
> 

