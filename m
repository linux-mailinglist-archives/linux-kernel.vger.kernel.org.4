Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBAE6779B7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjAWK7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjAWK7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:59:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCF06233FB;
        Mon, 23 Jan 2023 02:59:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C149AD7;
        Mon, 23 Jan 2023 02:59:59 -0800 (PST)
Received: from [10.57.75.85] (unknown [10.57.75.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96F413F71A;
        Mon, 23 Jan 2023 02:59:16 -0800 (PST)
Message-ID: <d87ac82e-6e39-7f75-1cfc-9f96042c0fc7@arm.com>
Date:   Mon, 23 Jan 2023 10:59:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: linux-next: build warnings after merge of the coresight tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230123150513.4d9cf5cd@canb.auug.org.au>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230123150513.4d9cf5cd@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen

On 23/01/2023 04:05, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the coresight tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> Documentation/trace/coresight/coresight-tpda.rst:3: WARNING: Title overline too short.
> 
> ==============================
> The trace performance monitoring and diagnostics aggregator(TPDA).
> ==============================
> Documentation/trace/coresight/coresight-tpdm.rst:3: WARNING: Title overline too short.
> 
> ==============================
> Trace performance monitoring and diagnostics monitor(TPDM).
> ==============================
> 
> Introduced by commit
> 
>    758d638667d4 ("Documentation: trace: Add documentation for TPDM and TPDA")
> 

Thanks for the report, Bagas has sent a series to fix them, I will queue it.

https://lkml.kernel.org/r/20230121040015.28139-1-bagasdotme@gmail.com

Suzuki

