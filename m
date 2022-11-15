Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59566292E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiKOIE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiKOIEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:04:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5F111144;
        Tue, 15 Nov 2022 00:04:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AAF6F336D3;
        Tue, 15 Nov 2022 08:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668499490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1BaYDyqBU4ZwuFYZUTJoFEUipI1q9JjoBCdM0zV7xE=;
        b=RrjNg/4IwojvOHKidI9jRt9bQrfRo4llO/tv6a4iGsnthLKjXmZKNaTeAioEUwRqb8J7rf
        bmXDKXl3j9FnJqOhiIwGYxhF9V06Oz586yDsRurE9m5iHT02FUMZzYTRK5M89tRkAcYiIy
        4LPfNvF0C+3N3Au90yDUcEwRXyQqW54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668499490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1BaYDyqBU4ZwuFYZUTJoFEUipI1q9JjoBCdM0zV7xE=;
        b=3fzdVtvOlwDWMu1trS7HvBxh9k5KKEFL0Cqzpn5tyzxvjj6JhAGumVNOQyQK+HjzSyUiss
        0vwebidpf03ymyAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74F2513A91;
        Tue, 15 Nov 2022 08:04:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h9a3GyJIc2NhMwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 15 Nov 2022 08:04:50 +0000
Content-Type: multipart/mixed; boundary="------------ooVE3lwc3gyl8END0IzVq3j3"
Message-ID: <61b91b3c-bd4d-05a4-bb66-f4fd344fa45a@suse.de>
Date:   Tue, 15 Nov 2022 09:04:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312144415.20010-1-linux@zary.sk>
 <202211140853.11115.linux@zary.sk>
 <f8ce8ecd-cadd-d9ca-d2fa-1251804344f0@opensource.wdc.com>
 <202211142025.46723.linux@zary.sk>
 <dc4e757a-737d-0bfa-c85d-9521feaa8d5f@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <dc4e757a-737d-0bfa-c85d-9521feaa8d5f@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------ooVE3lwc3gyl8END0IzVq3j3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/15/22 04:06, Damien Le Moal wrote:
> On 11/15/22 04:25, Ondrej Zary wrote:
>> On Monday 14 November 2022 09:03:28 Damien Le Moal wrote:
>>> On 11/14/22 16:53, Ondrej Zary wrote:
>>>> On Monday 14 November 2022, Damien Le Moal wrote:
>>>>> On 11/12/22 20:17, Ondrej Zary wrote:
>>>>>> On Wednesday 19 October 2022 09:34:31 Christoph Hellwig wrote:
>>>>>>> It's been a while - did you get a chance to make some progress on
>>>>>>> this?  Do you need any help to unblock you?
>>>>>>>
>>>>>>
>>>>>> Sorry again, I'm back now. Trying to fix locking problems.
>>>>>> Added this to each function for analysis how the functions are called wrt.
>>>>>> locking:
>>>>>>
>>>>>> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
>>>>>
>>>>> Do you have your code somewhere that we can look at ?
>>>>
>>>> This is the current version with debug printks. I've also added dump_stack()
>>>> to find out the code path but haven't analyzed the output yet.
>>>
>>> Can you send a proper patch ? Or a link to a git tree ? That is easier to
>>> handle than pasted code in an email...
>>
>> Patch against what? I don't have a git server.
> 
> patch against current 6.1-rc, or against an older kernel should be OK too.
> But please "git send-email" a patch, or push your dev tree to github ?
> 
Please check the attachment; I've converted Ondrey mail to a patch 
relative to the original submission.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

--------------ooVE3lwc3gyl8END0IzVq3j3
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-pata_parport-debug-patch-for-locking-issues.patch"
Content-Disposition: attachment;
 filename="0001-pata_parport-debug-patch-for-locking-issues.patch"
Content-Transfer-Encoding: base64

RnJvbSA5OTQzMzBiYWZkNjhkYTg3NTQ2OTcxODA2NGFjNjIyZTQyYWRjYzk3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4K
RGF0ZTogVHVlLCAxNSBOb3YgMjAyMiAwODo1Nzo1MSArMDEwMApTdWJqZWN0OiBbUEFUQ0hd
IHBhdGFfcGFycG9ydDogZGVidWcgcGF0Y2ggZm9yIGxvY2tpbmcgaXNzdWVzCgpBZGQgbG9n
Z2luZyBtZXNzYWdlcyB0byBkZWJ1ZyBsb2NraW5nIGlzc3Vlcy4KClNpZ25lZC1vZmYtYnk6
IE9uZHJleSBaYXJ5IDxsaW51eEB6YXJ5LnNrPgotLS0KIGRyaXZlcnMvYXRhL3BhdGFfcGFy
cG9ydC5jIHwgMTEyICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspLCA1NiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2F0YS9wYXRhX3BhcnBvcnQuYyBiL2RyaXZlcnMvYXRhL3BhdGFf
cGFycG9ydC5jCmluZGV4IDc4Mzc2NDYyNmEyNy4uNTEzNTY3Y2U2NmEzIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2F0YS9wYXRhX3BhcnBvcnQuYworKysgYi9kcml2ZXJzL2F0YS9wYXRhX3Bh
cnBvcnQuYwpAQCAtMjUsOCArMjUsMTIgQEAgTU9EVUxFX1BBUk1fREVTQyh2ZXJib3NlLCAi
RW5hYmxlIHZlcmJvc2UgbWVzc2FnZXMgKDA9b2ZmIFtkZWZhdWx0XSwgMT1vbikiKTsKIAog
I2RlZmluZSBESVNDT05ORUNUX1RJTUVPVVQJKEhaIC8gMTApCiAKLXN0YXRpYyB2b2lkIHBp
X2Nvbm5lY3Qoc3RydWN0IHBpX2FkYXB0ZXIgKnBpKQorc3RhdGljIHZvaWQgcGlfY29ubmVj
dChzdHJ1Y3QgYXRhX3BvcnQgKmFwKQogeworCXN0cnVjdCBwaV9hZGFwdGVyICpwaSA9IGFw
LT5ob3N0LT5wcml2YXRlX2RhdGE7CisJaWYgKHNwaW5faXNfbG9ja2VkKGFwLT5sb2NrKSkK
KwkJZHVtcF9zdGFjaygpOworCiAJZGVsX3RpbWVyX3N5bmMoJnBpLT50aW1lcik7CiAJaWYg
KCFwaS0+Y2xhaW1lZCkgewogCQlwaS0+Y2xhaW1lZCA9IHRydWU7CkBAIC0zNSwxMCArMzks
OCBAQCBzdGF0aWMgdm9pZCBwaV9jb25uZWN0KHN0cnVjdCBwaV9hZGFwdGVyICpwaSkKIAl9
CiB9CiAKLXN0YXRpYyB2b2lkIHBpX2Rpc2Nvbm5lY3RfdGltZXIoc3RydWN0IHRpbWVyX2xp
c3QgKnQpCitzdGF0aWMgdm9pZCBwaV9kaXNjb25uZWN0KHN0cnVjdCBwaV9hZGFwdGVyICpw
aSkKIHsKLQlzdHJ1Y3QgcGlfYWRhcHRlciAqcGkgPSBmcm9tX3RpbWVyKHBpLCB0LCB0aW1l
cik7Ci0KIAlpZiAocGktPmNsYWltZWQpIHsKIAkJcGktPnByb3RvLT5kaXNjb25uZWN0KHBp
KTsKIAkJcGFycG9ydF9yZWxlYXNlKHBpLT5wYXJkZXYpOwpAQCAtNDYsMTggKzQ4LDI2IEBA
IHN0YXRpYyB2b2lkIHBpX2Rpc2Nvbm5lY3RfdGltZXIoc3RydWN0IHRpbWVyX2xpc3QgKnQp
CiAJfQogfQogCitzdGF0aWMgdm9pZCBwaV9kaXNjb25uZWN0X3RpbWVyKHN0cnVjdCB0aW1l
cl9saXN0ICp0KQoreworCXN0cnVjdCBwaV9hZGFwdGVyICpwaSA9IGZyb21fdGltZXIocGks
IHQsIHRpbWVyKTsKKworCXBpX2Rpc2Nvbm5lY3QocGkpOworfQorCiAvKiBmdW5jdGlvbnMg
dGFrZW4gZnJvbSBsaWJhdGEtc2ZmLmMgYW5kIGNvbnZlcnRlZCBmcm9tIGRpcmVjdCBwb3J0
IEkvTyAqLwogc3RhdGljIHZvaWQgcGF0YV9wYXJwb3J0X2Rldl9zZWxlY3Qoc3RydWN0IGF0
YV9wb3J0ICphcCwgdW5zaWduZWQgaW50IGRldmljZSkKIHsKIAlzdHJ1Y3QgcGlfYWRhcHRl
ciAqcGkgPSBhcC0+aG9zdC0+cHJpdmF0ZV9kYXRhOwogCXU4IHRtcDsKKwlwcmludGsoIiVz
LCBsb2NrZWQ9JWRcbiIsIF9fRlVOQ1RJT05fXywgc3Bpbl9pc19sb2NrZWQoYXAtPmxvY2sp
KTsKIAogCWlmIChkZXZpY2UgPT0gMCkKIAkJdG1wID0gQVRBX0RFVklDRV9PQlM7CiAJZWxz
ZQogCQl0bXAgPSBBVEFfREVWSUNFX09CUyB8IEFUQV9ERVYxOwogCi0JcGlfY29ubmVjdChw
aSk7CisJcGlfY29ubmVjdChhcCk7CiAJcGktPnByb3RvLT53cml0ZV9yZWdyKHBpLCAwLCBB
VEFfUkVHX0RFVklDRSwgdG1wKTsKIAltb2RfdGltZXIoJnBpLT50aW1lciwgamlmZmllcyAr
IERJU0NPTk5FQ1RfVElNRU9VVCk7CiAJYXRhX3NmZl9wYXVzZShhcCk7CkBAIC02NywxMCAr
NzcsMTAgQEAgc3RhdGljIGJvb2wgcGF0YV9wYXJwb3J0X2RldmNoayhzdHJ1Y3QgYXRhX3Bv
cnQgKmFwLCB1bnNpZ25lZCBpbnQgZGV2aWNlKQogewogCXN0cnVjdCBwaV9hZGFwdGVyICpw
aSA9IGFwLT5ob3N0LT5wcml2YXRlX2RhdGE7CiAJdTggbnNlY3QsIGxiYWw7Ci0KKwlwcmlu
dGsoIiVzLCBsb2NrZWQ9JWRcbiIsIF9fRlVOQ1RJT05fXywgc3Bpbl9pc19sb2NrZWQoYXAt
PmxvY2spKTsKIAlwYXRhX3BhcnBvcnRfZGV2X3NlbGVjdChhcCwgZGV2aWNlKTsKIAotCXBp
X2Nvbm5lY3QocGkpOworCXBpX2Nvbm5lY3QoYXApOwogCXBpLT5wcm90by0+d3JpdGVfcmVn
cihwaSwgMCwgQVRBX1JFR19OU0VDVCwgMHg1NSk7CiAJcGktPnByb3RvLT53cml0ZV9yZWdy
KHBpLCAwLCBBVEFfUkVHX0xCQUwsIDB4YWEpOwogCkBAIC05NCw4ICsxMDQsOCBAQCBzdGF0
aWMgaW50IHBhdGFfcGFycG9ydF9idXNfc29mdHJlc2V0KHN0cnVjdCBhdGFfcG9ydCAqYXAs
IHVuc2lnbmVkIGludCBkZXZtYXNrLAogCQkJCSAgICAgIHVuc2lnbmVkIGxvbmcgZGVhZGxp
bmUpCiB7CiAJc3RydWN0IHBpX2FkYXB0ZXIgKnBpID0gYXAtPmhvc3QtPnByaXZhdGVfZGF0
YTsKLQotCXBpX2Nvbm5lY3QocGkpOworCXByaW50aygiJXMsIGxvY2tlZD0lZFxuIiwgX19G
VU5DVElPTl9fLCBzcGluX2lzX2xvY2tlZChhcC0+bG9jaykpOworCXBpX2Nvbm5lY3QoYXAp
OwogCS8qIHNvZnR3YXJlIHJlc2V0LiAgY2F1c2VzIGRldjAgdG8gYmUgc2VsZWN0ZWQgKi8K
IAlwaS0+cHJvdG8tPndyaXRlX3JlZ3IocGksIDEsIDYsIGFwLT5jdGwpOwogCXVkZWxheSgy
MCk7CkBAIC0xMTYsNyArMTI2LDcgQEAgc3RhdGljIGludCBwYXRhX3BhcnBvcnRfc29mdHJl
c2V0KHN0cnVjdCBhdGFfbGluayAqbGluaywgdW5zaWduZWQgaW50ICpjbGFzc2VzLAogCXVu
c2lnbmVkIGludCBkZXZtYXNrID0gMDsKIAlpbnQgcmM7CiAJdTggZXJyOwotCisJcHJpbnRr
KCIlcywgbG9ja2VkPSVkXG4iLCBfX0ZVTkNUSU9OX18sIHNwaW5faXNfbG9ja2VkKGFwLT5s
b2NrKSk7CiAJLyogZGV0ZXJtaW5lIGlmIGRldmljZSAwLzEgYXJlIHByZXNlbnQgKi8KIAlp
ZiAocGF0YV9wYXJwb3J0X2RldmNoayhhcCwgMCkpCiAJCWRldm1hc2sgfD0gKDEgPDwgMCk7
CkBAIC0xNDcsOCArMTU3LDggQEAgc3RhdGljIHU4IHBhdGFfcGFycG9ydF9jaGVja19zdGF0
dXMoc3RydWN0IGF0YV9wb3J0ICphcCkKIHsKIAl1OCBzdGF0dXM7CiAJc3RydWN0IHBpX2Fk
YXB0ZXIgKnBpID0gYXAtPmhvc3QtPnByaXZhdGVfZGF0YTsKLQotCXBpX2Nvbm5lY3QocGkp
OworCXByaW50aygiJXMsIGxvY2tlZD0lZFxuIiwgX19GVU5DVElPTl9fLCBzcGluX2lzX2xv
Y2tlZChhcC0+bG9jaykpOworCXBpX2Nvbm5lY3QoYXApOwogCXN0YXR1cyA9IHBpLT5wcm90
by0+cmVhZF9yZWdyKHBpLCAwLCBBVEFfUkVHX1NUQVRVUyk7CiAJbW9kX3RpbWVyKCZwaS0+
dGltZXIsIGppZmZpZXMgKyBESVNDT05ORUNUX1RJTUVPVVQpOwogCkBAIC0xNTksOCArMTY5
LDggQEAgc3RhdGljIHU4IHBhdGFfcGFycG9ydF9jaGVja19hbHRzdGF0dXMoc3RydWN0IGF0
YV9wb3J0ICphcCkKIHsKIAl1OCBhbHRzdGF0dXM7CiAJc3RydWN0IHBpX2FkYXB0ZXIgKnBp
ID0gYXAtPmhvc3QtPnByaXZhdGVfZGF0YTsKLQotCXBpX2Nvbm5lY3QocGkpOworCXByaW50
aygiJXMsIGxvY2tlZD0lZFxuIiwgX19GVU5DVElPTl9fLCBzcGluX2lzX2xvY2tlZChhcC0+
bG9jaykpOworCXBpX2Nvbm5lY3QoYXApOwogCWFsdHN0YXR1cyA9IHBpLT5wcm90by0+cmVh
ZF9yZWdyKHBpLCAxLCA2KTsKIAltb2RfdGltZXIoJnBpLT50aW1lciwgamlmZmllcyArIERJ
U0NPTk5FQ1RfVElNRU9VVCk7CiAKQEAgLTE3MSw4ICsxODEsOCBAQCBzdGF0aWMgdm9pZCBw
YXRhX3BhcnBvcnRfdGZfbG9hZChzdHJ1Y3QgYXRhX3BvcnQgKmFwLAogCQkJCSBjb25zdCBz
dHJ1Y3QgYXRhX3Rhc2tmaWxlICp0ZikKIHsKIAlzdHJ1Y3QgcGlfYWRhcHRlciAqcGkgPSBh
cC0+aG9zdC0+cHJpdmF0ZV9kYXRhOwotCi0JcGlfY29ubmVjdChwaSk7CisJcHJpbnRrKCIl
cywgbG9ja2VkPSVkXG4iLCBfX0ZVTkNUSU9OX18sIHNwaW5faXNfbG9ja2VkKGFwLT5sb2Nr
KSk7CisJcGlfY29ubmVjdChhcCk7CiAJaWYgKHRmLT5jdGwgIT0gYXAtPmxhc3RfY3RsKSB7
CiAJCXBpLT5wcm90by0+d3JpdGVfcmVncihwaSwgMSwgNiwgdGYtPmN0bCk7CiAJCWFwLT5s
YXN0X2N0bCA9IHRmLT5jdGw7CkBAIC0yMDksOCArMjE5LDggQEAgc3RhdGljIHZvaWQgcGF0
YV9wYXJwb3J0X3RmX2xvYWQoc3RydWN0IGF0YV9wb3J0ICphcCwKIHN0YXRpYyB2b2lkIHBh
dGFfcGFycG9ydF90Zl9yZWFkKHN0cnVjdCBhdGFfcG9ydCAqYXAsIHN0cnVjdCBhdGFfdGFz
a2ZpbGUgKnRmKQogewogCXN0cnVjdCBwaV9hZGFwdGVyICpwaSA9IGFwLT5ob3N0LT5wcml2
YXRlX2RhdGE7Ci0KLQlwaV9jb25uZWN0KHBpKTsKKwlwcmludGsoIiVzLCBsb2NrZWQ9JWRc
biIsIF9fRlVOQ1RJT05fXywgc3Bpbl9pc19sb2NrZWQoYXAtPmxvY2spKTsKKwlwaV9jb25u
ZWN0KGFwKTsKIAl0Zi0+c3RhdHVzID0gcGktPnByb3RvLT5yZWFkX3JlZ3IocGksIDAsIEFU
QV9SRUdfU1RBVFVTKTsKIAl0Zi0+ZXJyb3IgPSBwaS0+cHJvdG8tPnJlYWRfcmVncihwaSwg
MCwgQVRBX1JFR19FUlIpOwogCXRmLT5uc2VjdCA9IHBpLT5wcm90by0+cmVhZF9yZWdyKHBp
LCAwLCBBVEFfUkVHX05TRUNUKTsKQEAgLTIzNiw4ICsyNDYsOCBAQCBzdGF0aWMgdm9pZCBw
YXRhX3BhcnBvcnRfZXhlY19jb21tYW5kKHN0cnVjdCBhdGFfcG9ydCAqYXAsCiAJCQkJICAg
ICAgY29uc3Qgc3RydWN0IGF0YV90YXNrZmlsZSAqdGYpCiB7CiAJc3RydWN0IHBpX2FkYXB0
ZXIgKnBpID0gYXAtPmhvc3QtPnByaXZhdGVfZGF0YTsKLQotCXBpX2Nvbm5lY3QocGkpOwor
CXByaW50aygiJXMsIGxvY2tlZD0lZFxuIiwgX19GVU5DVElPTl9fLCBzcGluX2lzX2xvY2tl
ZChhcC0+bG9jaykpOworCXBpX2Nvbm5lY3QoYXApOwogCXBpLT5wcm90by0+d3JpdGVfcmVn
cihwaSwgMCwgQVRBX1JFR19DTUQsIHRmLT5jb21tYW5kKTsKIAlhdGFfc2ZmX3BhdXNlKGFw
KTsKIAltb2RfdGltZXIoJnBpLT50aW1lciwgamlmZmllcyArIERJU0NPTk5FQ1RfVElNRU9V
VCk7CkBAIC0yNDgsOCArMjU4LDggQEAgc3RhdGljIHVuc2lnbmVkIGludCBwYXRhX3BhcnBv
cnRfZGF0YV94ZmVyKHN0cnVjdCBhdGFfcXVldWVkX2NtZCAqcWMsCiB7CiAJc3RydWN0IGF0
YV9wb3J0ICphcCA9IHFjLT5kZXYtPmxpbmstPmFwOwogCXN0cnVjdCBwaV9hZGFwdGVyICpw
aSA9IGFwLT5ob3N0LT5wcml2YXRlX2RhdGE7Ci0KLQlwaV9jb25uZWN0KHBpKTsKKwlwcmlu
dGsoIiVzLCBsb2NrZWQ9JWRcbiIsIF9fRlVOQ1RJT05fXywgc3Bpbl9pc19sb2NrZWQoYXAt
PmxvY2spKTsKKwlwaV9jb25uZWN0KGFwKTsKIAlpZiAocncgPT0gUkVBRCkKIAkJcGktPnBy
b3RvLT5yZWFkX2Jsb2NrKHBpLCBidWYsIGJ1Zmxlbik7CiAJZWxzZQpAQCAtMjcxLDExICsy
ODEsMTIgQEAgc3RhdGljIHZvaWQgcGF0YV9wYXJwb3J0X2RyYWluX2ZpZm8oc3RydWN0IGF0
YV9xdWV1ZWRfY21kICpxYykKIAkJcmV0dXJuOwogCiAJYXAgPSBxYy0+YXA7CisJcHJpbnRr
KCIlcywgbG9ja2VkPSVkXG4iLCBfX0ZVTkNUSU9OX18sIHNwaW5faXNfbG9ja2VkKGFwLT5s
b2NrKSk7CiAJcGkgPSBhcC0+aG9zdC0+cHJpdmF0ZV9kYXRhOwogCS8qIERyYWluIHVwIHRv
IDY0SyBvZiBkYXRhIGJlZm9yZSB3ZSBnaXZlIHVwIHRoaXMgcmVjb3ZlcnkgbWV0aG9kICov
CiAJZm9yIChjb3VudCA9IDA7IChwYXRhX3BhcnBvcnRfY2hlY2tfc3RhdHVzKGFwKSAmIEFU
QV9EUlEpCiAJCQkJCQkmJiBjb3VudCA8IDY1NTM2OyBjb3VudCArPSAyKSB7Ci0JCXBpX2Nv
bm5lY3QocGkpOworCQlwaV9jb25uZWN0KGFwKTsKIAkJcGktPnByb3RvLT5yZWFkX2Jsb2Nr
KHBpLCBqdW5rLCAyKTsKIAkJbW9kX3RpbWVyKCZwaS0+dGltZXIsIGppZmZpZXMgKyBESVND
T05ORUNUX1RJTUVPVVQpOwogCX0KQEAgLTI4NCwzMyArMjk1LDYgQEAgc3RhdGljIHZvaWQg
cGF0YV9wYXJwb3J0X2RyYWluX2ZpZm8oc3RydWN0IGF0YV9xdWV1ZWRfY21kICpxYykKIAkJ
YXRhX3BvcnRfZGJnKGFwLCAiZHJhaW5lZCAlZCBieXRlcyB0byBjbGVhciBEUlFcbiIsIGNv
dW50KTsKIH0KIAotc3RhdGljIHZvaWQgcGF0YV9wYXJwb3J0X2xvc3RfaW50ZXJydXB0KHN0
cnVjdCBhdGFfcG9ydCAqYXApCi17Ci0JdTggc3RhdHVzOwotCXN0cnVjdCBhdGFfcXVldWVk
X2NtZCAqcWM7Ci0KLQkvKiBPbmx5IG9uZSBvdXRzdGFuZGluZyBjb21tYW5kIHBlciBTRkYg
Y2hhbm5lbCAqLwotCXFjID0gYXRhX3FjX2Zyb21fdGFnKGFwLCBhcC0+bGluay5hY3RpdmVf
dGFnKTsKLQkvKiBXZSBjYW5ub3QgbG9zZSBhbiBpbnRlcnJ1cHQgb24gYSBub24tZXhpc3Rl
bnQgb3IgcG9sbGVkIGNvbW1hbmQgKi8KLQlpZiAoIXFjIHx8IHFjLT50Zi5mbGFncyAmIEFU
QV9URkxBR19QT0xMSU5HKQotCQlyZXR1cm47Ci0JLyoKLQkgKiBTZWUgaWYgdGhlIGNvbnRy
b2xsZXIgdGhpbmtzIGl0IGlzIHN0aWxsIGJ1c3kgLSBpZiBzbyB0aGUgY29tbWFuZAotCSAq
IGlzbid0IGEgbG9zdCBJUlEgYnV0IGlzIHN0aWxsIGluIHByb2dyZXNzCi0JICovCi0Jc3Rh
dHVzID0gcGF0YV9wYXJwb3J0X2NoZWNrX2FsdHN0YXR1cyhhcCk7Ci0JaWYgKHN0YXR1cyAm
IEFUQV9CVVNZKQotCQlyZXR1cm47Ci0KLQkvKgotCSAqIFRoZXJlIHdhcyBhIGNvbW1hbmQg
cnVubmluZywgd2UgYXJlIG5vIGxvbmdlciBidXN5IGFuZCB3ZSBoYXZlCi0JICogbm8gaW50
ZXJydXB0LgotCSAqLwotCWF0YV9wb3J0X3dhcm4oYXAsICJsb3N0IGludGVycnVwdCAoU3Rh
dHVzIDB4JXgpXG4iLCBzdGF0dXMpOwotCS8qIFJ1biB0aGUgaG9zdCBpbnRlcnJ1cHQgbG9n
aWMgYXMgaWYgdGhlIGludGVycnVwdCBoYWQgbm90IGJlZW4gbG9zdCAqLwotCWF0YV9zZmZf
cG9ydF9pbnRyKGFwLCBxYyk7Ci19Ci0KIHN0YXRpYyBzdHJ1Y3QgYXRhX3BvcnRfb3BlcmF0
aW9ucyBwYXRhX3BhcnBvcnRfcG9ydF9vcHMgPSB7CiAJLmluaGVyaXRzCQk9ICZhdGFfc2Zm
X3BvcnRfb3BzLAogCkBAIC0zMjUsOCArMzA5LDYgQEAgc3RhdGljIHN0cnVjdCBhdGFfcG9y
dF9vcGVyYXRpb25zIHBhdGFfcGFycG9ydF9wb3J0X29wcyA9IHsKIAkuc2ZmX2V4ZWNfY29t
bWFuZAk9IHBhdGFfcGFycG9ydF9leGVjX2NvbW1hbmQsCiAJLnNmZl9kYXRhX3hmZXIJCT0g
cGF0YV9wYXJwb3J0X2RhdGFfeGZlciwKIAkuc2ZmX2RyYWluX2ZpZm8JCT0gcGF0YV9wYXJw
b3J0X2RyYWluX2ZpZm8sCi0KLQkubG9zdF9pbnRlcnJ1cHQJCT0gcGF0YV9wYXJwb3J0X2xv
c3RfaW50ZXJydXB0LAogfTsKIAogc3RhdGljIGNvbnN0IHN0cnVjdCBhdGFfcG9ydF9pbmZv
IHBhdGFfcGFycG9ydF9wb3J0X2luZm8gPSB7CkBAIC00NzMsNiArNDU1LDE5IEBAIHN0YXRp
YyBzdHJ1Y3Qgc2NzaV9ob3N0X3RlbXBsYXRlIHBhdGFfcGFycG9ydF9zaHQgPSB7CiAJUEFU
QV9QQVJQT1JUX1NIVCgicGF0YV9wYXJwb3J0IikKIH07CiAKK3N0cnVjdCBwaV9kZXZpY2Vf
bWF0Y2ggeworCXN0cnVjdCBwYXJwb3J0ICpwYXJwb3J0OworCXN0cnVjdCBwaV9wcm90b2Nv
bCAqcHJvdG87Cit9OworCitzdGF0aWMgaW50IHBpX2ZpbmRfZGV2KHN0cnVjdCBkZXZpY2Ug
KmRldiwgdm9pZCAqZGF0YSkKK3sKKwlzdHJ1Y3QgcGlfYWRhcHRlciAqcGkgPSBjb250YWlu
ZXJfb2YoZGV2LCBzdHJ1Y3QgcGlfYWRhcHRlciwgZGV2KTsKKwlzdHJ1Y3QgcGlfZGV2aWNl
X21hdGNoICptYXRjaCA9IGRhdGE7CisKKwlyZXR1cm4gcGktPnBhcmRldi0+cG9ydCA9PSBt
YXRjaC0+cGFycG9ydCAmJiBwaS0+cHJvdG8gPT0gbWF0Y2gtPnByb3RvOworfQorCiBzdGF0
aWMgc3RydWN0IHBpX2FkYXB0ZXIgKnBpX2luaXRfb25lKHN0cnVjdCBwYXJwb3J0ICpwYXJw
b3J0LAogCQkJc3RydWN0IHBpX3Byb3RvY29sICpwciwgaW50IG1vZGUsIGludCB1bml0LCBp
bnQgZGVsYXkpCiB7CkBAIC00ODEsNiArNDc2LDE0IEBAIHN0YXRpYyBzdHJ1Y3QgcGlfYWRh
cHRlciAqcGlfaW5pdF9vbmUoc3RydWN0IHBhcnBvcnQgKnBhcnBvcnQsCiAJY29uc3Qgc3Ry
dWN0IGF0YV9wb3J0X2luZm8gKnBwaVtdID0geyAmcGF0YV9wYXJwb3J0X3BvcnRfaW5mbyB9
OwogCXN0cnVjdCBhdGFfaG9zdCAqaG9zdDsKIAlzdHJ1Y3QgcGlfYWRhcHRlciAqcGk7CisJ
c3RydWN0IHBpX2RldmljZV9tYXRjaCBtYXRjaCA9IHsgLnBhcnBvcnQgPSBwYXJwb3J0LCAu
cHJvdG8gPSBwciB9OworCisJLyoKKwkgKiBBYm9ydCBpZiB0aGVyZSdzIGEgZGV2aWNlIGFs
cmVhZHkgcmVnaXN0ZXJlZCBvbiB0aGUgc2FtZSBwYXJwb3J0CisJICogdXNpbmcgdGhlIHNh
bWUgcHJvdG9jb2wuCisJICovCisJaWYgKGJ1c19mb3JfZWFjaF9kZXYoJnBhdGFfcGFycG9y
dF9idXNfdHlwZSwgTlVMTCwgJm1hdGNoLCBwaV9maW5kX2RldikpCisJCXJldHVybiBOVUxM
OwogCiAJcGkgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgcGlfYWRhcHRlciksIEdGUF9LRVJO
RUwpOwogCWlmICghcGkpCkBAIC02NzQsMTAgKzY3Nyw3IEBAIHN0YXRpYyB2b2lkIHBpX3Jl
bW92ZV9vbmUoc3RydWN0IGRldmljZSAqZGV2KQogCiAJYXRhX2hvc3RfZGV0YWNoKGhvc3Qp
OwogCWRlbF90aW1lcl9zeW5jKCZwaS0+dGltZXIpOwotCWlmIChwaS0+Y2xhaW1lZCkgewot
CQlwaS0+cHJvdG8tPmRpc2Nvbm5lY3QocGkpOwotCQlwYXJwb3J0X3JlbGVhc2UocGktPnBh
cmRldik7Ci0JfQorCXBpX2Rpc2Nvbm5lY3QocGkpOwogCXBpX3JlbGVhc2UocGkpOwogCWRl
dmljZV91bnJlZ2lzdGVyKGRldik7CiAJaWRhX2ZyZWUoJnBhdGFfcGFycG9ydF9idXNfZGV2
X2lkcywgZGV2LT5pZCk7Ci0tIAoyLjM1LjMKCg==

--------------ooVE3lwc3gyl8END0IzVq3j3--
