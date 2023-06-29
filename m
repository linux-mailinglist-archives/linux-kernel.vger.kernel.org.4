Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017C6741DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjF2CFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF2CFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969211BC5;
        Wed, 28 Jun 2023 19:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FFFE614B0;
        Thu, 29 Jun 2023 02:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A69C433C8;
        Thu, 29 Jun 2023 02:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688004298;
        bh=fTFWRINOOl7/kp00dEn8HlW3RQeikx6X9pnA2wK/uBo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=klGi2It+E4lhz3rL/WxD3MKP4RrJxrGk5/Bti/617ehXUWJwwKww2H4tshovaa7ss
         URT8KVz1TvIzzbbbyTvjnT+TP+rVha1kFcdyZHmU4WhDIh+QrfI8XU283WhJ1haIns
         hgrsRjRtAN7/GVx43FC93DSEmnPCAZ+EKpndfgCwnRtUgjiCMmwV9KHR5vPRWzawA/
         keTsl2mTqeO+ennIkgZqJxckfixg1etPe4ZYGl1SjJ9JvPFWsb08zYYGJF9XLOFE50
         fTfGyY836YxkFW7Df1yCmK4ltcvsIArdFzVmdy5daadVllnixXOp6/Be6YcpjdVd4I
         dl0sPhT/EP4lQ==
Message-ID: <b47dd3e3-8ad5-e8c7-34fe-a0c0485e7f40@kernel.org>
Date:   Thu, 29 Jun 2023 10:04:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5] scsi: support packing multi-segment in UNMAP command
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com, hch@infradead.org, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310123604.1820231-1-chao@kernel.org>
 <b53321ab-679d-e007-6407-6bd00149948e@kernel.org>
 <yq17ct0nijm.fsf@ca-mkp.ca.oracle.com>
 <f93949dd-e90f-a9bf-33b3-4f31c4328c7d@kernel.org>
 <yq1sfabni01.fsf@ca-mkp.ca.oracle.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <yq1sfabni01.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 2023/6/29 10:02, Martin K. Petersen wrote:
> 
> Chao,
> 
>> Any progress on this patch?
> 
> I'll resubmit this series for 6.6.

Martin,

Thank you!

Thanks,

> 
