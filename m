Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378AB5F4F70
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJEFRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJEFRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:17:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068CC66A68;
        Tue,  4 Oct 2022 22:17:44 -0700 (PDT)
Received: from [192.168.10.9] (unknown [39.45.36.108])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B77B66022AB;
        Wed,  5 Oct 2022 06:17:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664947063;
        bh=Addv98tABUtrkD/Cgnp+ahnU5GCS4OSD2Wq6YkM6lXw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G6yezMwaGIsWK6qDr+RtFaaTZLyc75nn9QOHRd3Yf6pHvsol9rAZcBLfdTpUT82Pv
         IYY4pfb9a/jAvaBXuY0kGlz49M+Ow0um46SAWm7HZtMEw7EfdJD6qaZMs4RZddO+5R
         ABCLgqAi7v+awY4eMVzCRBHQb0EV7FYyy8HMbOYt3KGmQv+Lx0aeFswmM4VthwGfcT
         06wSeYjgIZuKXb+QF0CM2eXhde3QJB995b1Ss/8RxdqZE+bmGA1coQMTeuXLX6npWd
         bT7I/sHJhj307G5g7ER643GL70sFFwY3lIic5Gwr15vopov22Sz0HoYTVVHaUsg6yi
         8qA1fNTpyKkpg==
Message-ID: <1f5c25d6-ca8f-1e6d-b451-9f9074056cb0@collabora.com>
Date:   Wed, 5 Oct 2022 10:17:36 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] cifs: check returned value for error
Content-Language: en-US
To:     Paulo Alcantara <pc@cjr.nz>, Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>
Cc:     kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
References: <20221004062333.416225-1-usama.anjum@collabora.com>
 <20221004062333.416225-2-usama.anjum@collabora.com> <87lepv4dm3.fsf@cjr.nz>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <87lepv4dm3.fsf@cjr.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 12:01 AM, Paulo Alcantara wrote:
> Muhammad Usama Anjum <usama.anjum@collabora.com> writes:
> 
>> smb311_decode_neg_context() can return error. Its return value should be
>> checked for errors.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   fs/cifs/smb2pdu.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
>> index 2bf43c892ae6..c6e37352dbe1 100644
> 
> This patch doesn't apply in Steve's for-next branch[1].  If it still
> makes sense, please rebase and resend.
> 
> [1] git://git.samba.org/sfrench/cifs-2.6.git
I've just applied on the latest next next-20221004 tag. This patch 
doesn't apply. It seems some other patch has merged and this patch isn't 
needed.

Can you apply only the first patch "[PATCH 1/2] cifs: remove 
initialization value" from this series? Or should I send that only as v2?
