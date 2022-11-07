Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E74761F5DF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiKGO1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiKGO1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:27:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BC827FCD;
        Mon,  7 Nov 2022 06:20:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A03B6104F;
        Mon,  7 Nov 2022 14:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB45C433B5;
        Mon,  7 Nov 2022 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667830841;
        bh=AwlZonmYoSagHAdZq3BTugX4OMvuo8eQJXbQG7hNrD8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HKvEUUqAJyQoTVRDFUnTOs9iRfRVsTiLkkb5Ubje4UkWZDNiD95aWBlmvcGuWjPIl
         6Peb161GQ0SJVS+HUrDTbUb6/U4Y7Uj9flDWiGEtCilpw4r6qTyDUiO9NAJYl/mC34
         zgEJTIJbmCOQwMq2Wj8qs86b3ZO5sGWA9dkO/ddKKZURVg2rEPDnHhK/QHGUBFJlh0
         xaq1Obpkx6EJVh/zmIlmJ4anUSnpyV/fYFtPT1WGvgeM/v6osQJ8m8KubwqR0XYipG
         7L/uebj04vV4TmgV9WDkKBeNu42QS4lQSoKfkWVR7L2ySew+GYvquvYtj1CggP5coZ
         MyppttBNjkIoQ==
Message-ID: <364685cb-da5f-f4f3-92cf-7b638ba96f8c@kernel.org>
Date:   Mon, 7 Nov 2022 15:20:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] rtla: Fix exit status when returning from calls to
 usage()
Content-Language: en-US
To:     John Kacur <jkacur@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Chang Yin <cyin@redhat.com>
References: <20221103135742.9523-1-jkacur@redhat.com>
 <b4639b19-94e3-2128-643e-6a3a44a1d944@kernel.org>
 <ca3dce1a-98d0-109a-f4d-d35b6ee2399a@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <ca3dce1a-98d0-109a-f4d-d35b6ee2399a@redhat.com>
Content-Type: text/plain; charset=UTF-8
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

On 11/7/22 14:53, John Kacur wrote:
> 
> On Fri, 4 Nov 2022, Daniel Bristot de Oliveira wrote:
> 
>> On 11/3/22 14:57, John Kacur wrote:
>>> rtla_usage(), osnoise_usage() and timerlat_usage() all exit with an
>>> error status
>> missing .
> ?
> 

rtla_usage(), osnoise_usage() and timerlat_usage() all exit with an
error status.

and so on...

-- Daniel
