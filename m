Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9474189B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjF1TFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:05:38 -0400
Received: from fanzine2.igalia.com ([213.97.179.56]:37532 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjF1TFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=r9HQfO+LulG/CFpB3NbTT9y4/r6X5wyFdGlUh8x2VXs=; b=lo5OreLdmz19JO3Mn3oBkEP7U9
        daOToL/V0cX+MN0jC8F9SqHxGUNykeQAaQC8WoBPEOczY9TdT6TXUpGf/0L1siUoBDwsPLb8ikAiR
        D2UvVI41Y2LePqLcbvWyKqwkYTXdHaSVrCL8eiGEuHQE8IRyXVMdE1f9XU1Y0/4eRlvF7M+e89eVF
        exGO98oLPVHu6YcYAwdxxUkyfVNJmN42/qid2rwg/BYOlNJHxwww7Z8UwLTi7eiZwe6MSYmpLTCDx
        Q7m+y+jPCq0wOCGnTKdzxgb5DE2EVddRpDHMF3TAGhn0/f0jnbxQr4modF0QXVU0a13nr1tPnxcO3
        vHzhxxVQ==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qEaTR-005OJQ-71; Wed, 28 Jun 2023 21:05:05 +0200
Message-ID: <7e497225-5911-93b3-b46e-f52d81ff5d1d@igalia.com>
Date:   Wed, 28 Jun 2023 16:05:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc
 limitation
Content-Language: en-US
To:     Yuxiao Zhang <yuxiaozhang@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        wak@google.com
References: <b2d66d9f-15a6-415c-2485-44649027a1d5@igalia.com>
 <20230628184820.1375994-1-yuxiaozhang@google.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230628184820.1375994-1-yuxiaozhang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2023 20:48, Yuxiao Zhang wrote:
> [...]
> What record type are you testing? I should have mention that this patch is only for pmsg use case on ramoops (I mentioned it in the original thread but need to start a new one due to format issue).

Oh, my bad! I'm collecting oops log, so the change is not really related
to my case. It is in the patch title, so my fault not reading that
properly heheh


> 
> Right, that is why this patch only touches the pstore ram path, I am not sure how things will go if it is block device backed.

It makes sense!
Thanks,


Guilherme
