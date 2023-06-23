Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524B273B022
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjFWFgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjFWFgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6C81A4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:36:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 016B361988
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD764C433C8;
        Fri, 23 Jun 2023 05:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687498605;
        bh=cyJ18XJOsD6QqIdxMxdfb/5pcchOwMqfqhVEcByr0QI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eFK63DEvCxqhCO5luGsgIpztog92DAFaK60FtPEUQEM9ywrxLDS32y3Q5wXq2nMJb
         bdFVdWlg1wwrYQeWYZTcvAP936ogMRYeaStxcvWS1xze0o50HU4lZIF78s5fEHPD6+
         Ygd6l7VH3SlVSBHHgQdMhLvTLxg8pD/m5NzFoyyKW4hIOC4NdAIWSN707e8BDSKA6p
         zZL942Kby/y2anXq0jQJP6B7tUF0v7M6tQEmGm1vv7SPN2b7xxvYHyFdxUak36wCrT
         EZ7QLg++ZjwdD10+v5ZvbIfvHuxRJYRw0Il59q1IxhOhoae/Q/D1hDdNt47TDkvQ8K
         ZkUlEIRwyBXUA==
Message-ID: <239e7171-1d29-0208-ca6c-abc85ccbe0e9@kernel.org>
Date:   Fri, 23 Jun 2023 00:36:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 00/12] New Crypto service commands
Content-Language: en-US
To:     tien.sung.ang@intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20230623032029.1755017-1-tien.sung.ang@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230623032029.1755017-1-tien.sung.ang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/23 22:20, tien.sung.ang@intel.com wrote:
> From: Ang Tien Sung <tien.sung.ang@intel.com>
> 
> hi,
> This patch set comprises updates to the svc driver to add new crypto
> services for AES encryption/decryption, SHA2 digest generation, SHA2
> MAC verification, ECDSA hash signing, ECDSA SHA2 data signing, ECDSA
> hash signature verification, ECDSA SHA2 data signature verification
> crypto key management and lastly ECDSA public key retrieval.
> The additions of the commands are all standard entries to svc driver
> with minimal logic.
> 

I guess I'll ask the same question, who's the consumer for these?


> Ang Tien Sung (12):
>    firmware: stratix10-svc: support open & close crypto session
>    firmware: stratix10-svc: crypto key management
>    firmware: stratix10-svc: AES encrypt and decrypt
>    firmware: stratix10-svc: increase msg arg size
>    firmware: stratix10-svc: SHA-2 digest
>    firmware: stratix10-svc: HMAC SHA2 verify
>    firmware: stratix10-svc: ECDSA Hash signing
>    firmware: stratix10-svc: ECDSA SHA2 data signing
>    firmware: stratix10-svc: hash signature verification
>    firmware: stratix10-svc: SHA2 signature verification
>    firmware: stratix10-svc: public key request
>    firmware: stratix10-svc: ECDH request
> 
>   drivers/firmware/stratix10-svc.c              | 309 +++++++-
>   include/linux/firmware/intel/stratix10-smc.h  | 708 ++++++++++++++++++
>   .../firmware/intel/stratix10-svc-client.h     |  86 ++-
>   3 files changed, 1100 insertions(+), 3 deletions(-)
> 
