Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D738363836E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 06:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiKYFYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 00:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKYFYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 00:24:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1037E2B61C;
        Thu, 24 Nov 2022 21:24:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 10E9721AC0;
        Fri, 25 Nov 2022 05:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669353873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/y99RcsD6SvKx/7MgPxJzd+LTvlSOWmn26YrAUERjE=;
        b=gWZ02Q40JfCqXlkcYs20rcxZGkIuzYJeLXUTzdXevYDEnmKoGpXYVMLrYXevbpYrR4SVt5
        Ph3EeiNE/wIZiQkB/q4/7gwuOFfR2lvYWV7b01ef16fJ40CNWwohh4489eo2BFmVIUHiuE
        KicBe/OyMLzurzf358C+1P4Le64qJDU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D48221361C;
        Fri, 25 Nov 2022 05:24:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FcY7MpBRgGN3VQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 25 Nov 2022 05:24:32 +0000
Message-ID: <032ffc77-429d-c5c6-f7b3-34e61d8f99f4@suse.com>
Date:   Fri, 25 Nov 2022 06:24:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: linux-next: build failure after merge of the mm-hotfixes tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>
References: <20221125121051.311beecd@canb.auug.org.au>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221125121051.311beecd@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EticmVnjzw3LfO3tRKda3OpC"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EticmVnjzw3LfO3tRKda3OpC
Content-Type: multipart/mixed; boundary="------------OLFDBcmXh5WgWVzjl1UVlxOV";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 "kernelci.org bot" <bot@kernelci.org>
Message-ID: <032ffc77-429d-c5c6-f7b3-34e61d8f99f4@suse.com>
Subject: Re: linux-next: build failure after merge of the mm-hotfixes tree
References: <20221125121051.311beecd@canb.auug.org.au>
In-Reply-To: <20221125121051.311beecd@canb.auug.org.au>

--------------OLFDBcmXh5WgWVzjl1UVlxOV
Content-Type: multipart/mixed; boundary="------------u7CXln8IJpfUM7D30HnWCg1x"

--------------u7CXln8IJpfUM7D30HnWCg1x
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjUuMTEuMjIgMDI6MTAsIFN0ZXBoZW4gUm90aHdlbGwgd3JvdGU6DQo+IEhpIGFsbCwN
Cj4gDQo+IEFmdGVyIG1lcmdpbmcgdGhlIG1tLWhvdGZpeGVzIHRyZWUsIHRvZGF5J3MgbGlu
dXgtbmV4dCBidWlsZCAoYXJtDQo+IGFsbG1vZGNvbmZpZykgZmFpbGVkIGxpa2UgdGhpczoN
Cj4gDQo+IG1tL3Ztc2Nhbi5jOjQwOTA6OTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9u
IG9mIGZ1bmN0aW9uIOKAmHBtZF95b3VuZ+KAmTsgZGlkIHlvdSBtZWFuIOKAmHB0ZV95b3Vu
Z+KAmT8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQo+IA0KPiBD
YXVzZWQgYnkgY29tbWl0DQo+IA0KPiAgICAzZjg1ZTcxMWQ1YWYgKCJtbTogaW50cm9kdWNl
IGFyY2hfaGFzX2h3X25vbmxlYWZfcG1kX3lvdW5nKCkiKQ0KDQpBIHBhdGNoIGZpeGluZyB0
aGlzIGlzIGF2YWlsYWJsZSBhbHJlYWR5IChzZWUgYXR0YWNoZWQgbWFpbCkuDQoNCg0KSnVl
cmdlbg0K
--------------u7CXln8IJpfUM7D30HnWCg1x
Content-Type: message/rfc822; name="+
 mm-add-dummy-pmd_young-for-architectures-not-having-it.patch added to
 mm-hotfixes-unstable branch.eml"
Content-Disposition: attachment; filename*0="+
 mm-add-dummy-pmd_young-for-architectures-not-having-it.pat"; filename*1="ch
 added to mm-hotfixes-unstable branch.eml"
Content-Transfer-Encoding: 7bit

Return-Path: <jgross@suse.com>
Delivered-To: jgross
Received: from dovecot-director2.suse.de ([192.168.254.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	by imap2.suse-dmz.suse.de with LMTPS
	id gBTPMozjf2NiCgAAMHmgww
	(envelope-from <jgross@suse.com>)
	for <jgross>; Thu, 24 Nov 2022 21:35:08 +0000
Received: from smtp-in2.suse.de ([192.168.254.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	by dovecot-director2.suse.de with LMTPS
	id OKCWMYzjf2P7TwAApTUePA
	(envelope-from <jgross@suse.com>)
	for <jgross@imap.suse.de>; Thu, 24 Nov 2022 21:35:08 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-in2.suse.de (Postfix) with ESMTPS id 4NJB9S3Q6kzZMF
	for <jgross@suse.de>; Thu, 24 Nov 2022 21:35:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7um09FuEDJOg1iIMX0Z1DH/0P+FGU6LlcRg5OwbZCnpiuAY90l/Z2NwAQy743NjpogcBU71Pz/a/WHvf0OZvjCnEzefKp4KgbhveIsvVHRX7bjaBAC0/3+NK5UPIlHZqfIdbuRbOzAMKtRYBH9WdSojIWjvVhyDXxq08NXdOfqZ8GnolHg/wFfKDyD2LfsguG0Dk7nBpH9paOMjOaZdWN5UQ5wU/Il7EEyBRfYFDz7+zTkYk+acaet7HzSYTAwyntFuA++/ZA9FwBB0V4s78cdAdmbrewbH6BJe23k7f/TRk0OjlS0pALvsZJK7ZA9oWQTv6ETDrHvy9m7mGoT+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU17AZwQRTXXFinXGR/qYNV02fHuTlGOcxA4DVdI6y0=;
 b=AxrhwoL3nN2xH/rOzK3cZR8zaQSUrylCepmssKOx1JqCjvDmSA4mqv6ulnMz+UZL5jP48o14SvA6vkz7fNReCUjXengmgYW2HBeB8P27iZJg3HztJDlvnso5E+MVYUYFTerjCKSrs95kC51lW31TcFVoNYeHp/yXKPXD9PONHUcDqQIsJNQ2cP1agQgOmm192AV3hKixWdzbo/VbDCBj1KiY0r2qel7fB9GDRiuqUsJTRq+9JXMqupzJvStfdQRChIdyP0gopzcaICHAA2/BT4XsL//uR3CXFAXj+6CBLRhTDqmnGGsrDxsLO+5AxI3E2JAqZzcPVaRDh/fleOAfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 145.40.68.75) smtp.rcpttodomain=suse.com smtp.mailfrom=linux-foundation.org;
 dmarc=bestguesspass action=none header.from=linux-foundation.org; dkim=pass
 (signature was verified) header.d=linux-foundation.org; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU17AZwQRTXXFinXGR/qYNV02fHuTlGOcxA4DVdI6y0=;
 b=Jy7KKMuMm0srnhSHy3582GhWh6/iaBZSZFkNbPOJq2WqtFRh9Zf+5LEKg9E0AR771xNyN4XOfxD1sImedylUoKPo5RuhVPb7IPyuFn3iQlWP7zL5aBJhRf5lIYUnHlXtMOtzo4Dawn4drwpvXZIyX4pJnicOn8yPAmZ60RL/aPHMqkxUrZJn8IofZzSVY5wLQtgNNIV6U3C1cHX+FR/E6l939XDyDnOuZEWraDg1gpTRqJAO1dkS3PHxtkIfpJv0GE6vqfK52pYhSG3hQ2zKvjMCw2n/xu/W7A6NyP8a/vPaOQ1uKyBU/Sw2qKQhkQeMcZSWMqLJdHiCOzBCiEGRXw==
Resent-From: <jgross@suse.com>
Received: from AS9PR04CA0072.eurprd04.prod.outlook.com (2603:10a6:20b:48b::7)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 24 Nov
 2022 21:35:05 +0000
Received: from AM7EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:48b:cafe::9b) by AS9PR04CA0072.outlook.office365.com
 (2603:10a6:20b:48b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Thu, 24 Nov 2022 21:35:05 +0000
Received-SPF: Pass (protection.outlook.com: domain of linux-foundation.org
 designates 145.40.68.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=145.40.68.75; helo=ams.source.kernel.org; pr=C
Received: from ams.source.kernel.org (145.40.68.75) by
 AM7EUR03FT056.mail.protection.outlook.com (100.127.140.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Thu, 24 Nov 2022 21:35:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id C5088B828FE;
	Thu, 24 Nov 2022 21:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CF4C433D6;
	Thu, 24 Nov 2022 21:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1669325702;
	bh=dNgoxKE0iYPmrhBSkImo2Y9AUYBet5w9QPWe0PyUhLU=;
	h=Date:To:From:Subject:From;
	b=f70DgalT1wrCMhQIFPfASY+mVrD5p2koSWJ0aGp1fIG0KE6tTaStU6hY0Bud+bW8Z
	 XV9BhkgiGIL2U2KB8VxLOOZS3lyFvXEV8oyJ9OAXnzQ4vHskN7Rr55wQhvizhT3AQR
	 4IS66mRyEl83hQUN1uGUsWB9pTCvyA22AzwOFmAk=
Date: Thu, 24 Nov 2022 13:35:01 -0800
To: mm-commits@vger.kernel.org,yuzhao@google.com,tglx@linutronix.de,mingo@redhat.com,linux@eikelenboom.it,hpa@zytor.com,geert@linux-m68k.org,dave.hansen@linux.intel.com,bp@alien8.de,jgross@suse.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-add-dummy-pmd_young-for-architectures-not-having-it.patch added to mm-hotfixes-unstable branch
Message-Id: <20221124213502.78CF4C433D6@smtp.kernel.org>
X-EOPAttributedMessage: 0
X-EOPTenantAttributedMessage: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba:0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7EUR03FT056:EE_|VI1PR04MB7182:EE_
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 91890304-bbd2-449b-3853-08dace63c065
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IWUg9W0s6ikuVdHKZGlJJnwrm2wqZYLxzK4A2PPYT6QqDgv09hajU18OYLdLZN6V4MGY+uaOUsbEtHypn44zWbAztPSEYwl1iWnDl2tgz1kIwR1E/XTTqtZuTiCIL9G0+9NzftE+55ufDlg2VrU97TovPCTps+c3aeE/lkhBoTJxrh4zOn1NqymgCtAhBZaXu7X5oMyrvyLxxCWdXVlhCpDBgc+0f+eDhEdQuLrtL0oVOZQxpl4M6TNTBKnTycDywgrmUEsZd5tJ1Ns8qUvCMMnt6oU7R07FhnJuVVKX7Fq6S3+UCizt3RZkMBk3hwSMXO2K+xQilSh1sgr+IEn+gtjE9XZJVWtAABm1LKaFWQT78cJWmw/8masVWQAWIQz8moymgamyI/pIixqnuX6+yDb83BPFzx/T+Rnhtd8o3SpQuE+XzRBs0qt/7fXQcpectKlNZUIzkPdQxb2EkjzaOtFSnlcMp8NjDwOGt6jud8rCsF6A7kOIwqB0yV3l4XX2zdcB+n7ei0MugqLzjyoIyGht1M1N7sQ1F0VyyuSEgfNMGh/3xZOBr2sHmC7izVHGUlJl1mAUPWPUHb4uV95Qax2PMWIHr/99lX/m2KIRIPsQPn91kDFF9baQzhaTV1PkB1z+A8tmTSLbySzkrOgG45Xq6v9Lq0y0/uN9+c5Mrao7ubW3f6mmFPKHMw07qfCKRPV1vd3gRrzymEmDjyXPfsxYxOPVw4x7rULXmIXPStA=
X-Forefront-Antispam-Report:
	CIP:145.40.68.75;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ams.source.kernel.org;PTR:ams.source.kernel.org;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(39860400002)(376002)(451199015)(66899015)(86362001)(9686003)(498600001)(26005)(6966003)(42186006)(6266002)(7636003)(33656002)(356005)(921005)(7596003)(1076003)(2906002)(83380400001)(966005)(336012)(5660300002)(68406010)(316002)(70586007)(8676002);DIR:OUT;SFP:1101;
X-ExternalRecipientOutboundConnectors: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-ForwardingLoop:
	jgross@suse.com;f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 21:35:05.0977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91890304-bbd2-449b-3853-08dace63c065
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Spam-Level: 
Authentication-Results: smtp-in2.suse.de;
	dkim=pass header.d=mysuse.onmicrosoft.com header.s=selector1-mysuse-onmicrosoft-com header.b=Jy7KKMuM;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=f70DgalT;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=none;
	spf=pass (smtp-in2.suse.de: domain of jgross@suse.com designates 40.107.8.87 as permitted sender) smtp.mailfrom=jgross@suse.com
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [-5.61 / 50.00];
	 R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	 TO_DN_NONE(0.00)[];
	 DKIM_TRACE(0.00)[mysuse.onmicrosoft.com:+,linux-foundation.org:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FORGED_SENDER(0.30)[akpm@linux-foundation.org,jgross@suse.com];
	 SUSE_WHITELIST_SUSE_COMQ(-0.50)[];
	 SUSE_WHITELIST_SUSE_COM(-0.50)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 ARC_ALLOW(-1.00)[microsoft.com:s=arcselector9901:i=1];
	 ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	 FROM_NEQ_ENVFROM(0.10)[akpm@linux-foundation.org,jgross@suse.com];
	 FORGED_RECIPIENTS(2.00)[m:mm-commits@vger.kernel.org,m:yuzhao@google.com,m:tglx@linutronix.de,m:mingo@redhat.com,m:linux@eikelenboom.it,m:hpa@zytor.com,m:geert@linux-m68k.org,m:dave.hansen@linux.intel.com,m:bp@alien8.de,m:jgross@suse.com,m:akpm@linux-foundation.org,s:jgross@suse.de];
	 BAYES_HAM(-3.00)[100.00%];
	 R_DKIM_ALLOW(-0.20)[mysuse.onmicrosoft.com:s=selector1-mysuse-onmicrosoft-com,linux-foundation.org:s=korg];
	 RCVD_COUNT_FIVE(0.00)[5];
	 FROM_HAS_DN(0.00)[];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[linux-foundation.org];
	 DWL_DNSWL_LOW(-1.00)[linux-foundation.org:dkim];
	 RCVD_IN_DNSWL_NONE(1.00)[40.107.8.87:from];
	 RWL_MAILSPIKE_POSSIBLE(-0.50)[40.107.8.87:from];
	 RCVD_IN_DNSWL_HI(-1.00)[52.25.139.140:received,145.40.68.75:received]
X-Spam-Score: -5.61
X-Rspamd-Queue-Id: 4NJB9S3Q6kzZMF
X-Spam-Flag: NO


The patch titled
     Subject: mm: add dummy pmd_young() for architectures not having it
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-add-dummy-pmd_young-for-architectures-not-having-it.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-add-dummy-pmd_young-for-architectures-not-having-it.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Juergen Gross <jgross@suse.com>
Subject: mm: add dummy pmd_young() for architectures not having it

In order to avoid #ifdeffery add a dummy pmd_young() implementation as a
fallback.  This is required for the later patch "mm: introduce
arch_has_hw_nonleaf_pmd_young()".

Link: https://lkml.kernel.org/r/fd3ac3cd-7349-6bbd-890a-71a9454ca0b3@suse.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Yu Zhao <yuzhao@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Sander Eikelenboom <linux@eikelenboom.it>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/loongarch/include/asm/pgtable.h |    1 +
 arch/mips/include/asm/pgtable.h      |    1 +
 arch/riscv/include/asm/pgtable.h     |    1 +
 arch/s390/include/asm/pgtable.h      |    1 +
 arch/sparc/include/asm/pgtable_64.h  |    1 +
 arch/x86/include/asm/pgtable.h       |    1 +
 include/linux/pgtable.h              |    7 +++++++
 7 files changed, 13 insertions(+)

--- a/arch/loongarch/include/asm/pgtable.h~mm-add-dummy-pmd_young-for-architectures-not-having-it
+++ a/arch/loongarch/include/asm/pgtable.h
@@ -482,6 +482,7 @@ static inline pmd_t pmd_mkdirty(pmd_t pm
 	return pmd;
 }
 
+#define pmd_young pmd_young
 static inline int pmd_young(pmd_t pmd)
 {
 	return !!(pmd_val(pmd) & _PAGE_ACCESSED);
--- a/arch/mips/include/asm/pgtable.h~mm-add-dummy-pmd_young-for-architectures-not-having-it
+++ a/arch/mips/include/asm/pgtable.h
@@ -622,6 +622,7 @@ static inline pmd_t pmd_mkdirty(pmd_t pm
 	return pmd;
 }
 
+#define pmd_young pmd_young
 static inline int pmd_young(pmd_t pmd)
 {
 	return !!(pmd_val(pmd) & _PAGE_ACCESSED);
--- a/arch/riscv/include/asm/pgtable.h~mm-add-dummy-pmd_young-for-architectures-not-having-it
+++ a/arch/riscv/include/asm/pgtable.h
@@ -600,6 +600,7 @@ static inline int pmd_dirty(pmd_t pmd)
 	return pte_dirty(pmd_pte(pmd));
 }
 
+#define pmd_young pmd_young
 static inline int pmd_young(pmd_t pmd)
 {
 	return pte_young(pmd_pte(pmd));
--- a/arch/s390/include/asm/pgtable.h~mm-add-dummy-pmd_young-for-architectures-not-having-it
+++ a/arch/s390/include/asm/pgtable.h
@@ -763,6 +763,7 @@ static inline int pmd_dirty(pmd_t pmd)
 	return (pmd_val(pmd) & _SEGMENT_ENTRY_DIRTY) != 0;
 }
 
+#define pmd_young pmd_young
 static inline int pmd_young(pmd_t pmd)
 {
 	return (pmd_val(pmd) & _SEGMENT_ENTRY_YOUNG) != 0;
--- a/arch/sparc/include/asm/pgtable_64.h~mm-add-dummy-pmd_young-for-architectures-not-having-it
+++ a/arch/sparc/include/asm/pgtable_64.h
@@ -693,6 +693,7 @@ static inline unsigned long pmd_dirty(pm
 	return pte_dirty(pte);
 }
 
+#define pmd_young pmd_young
 static inline unsigned long pmd_young(pmd_t pmd)
 {
 	pte_t pte = __pte(pmd_val(pmd));
--- a/arch/x86/include/asm/pgtable.h~mm-add-dummy-pmd_young-for-architectures-not-having-it
+++ a/arch/x86/include/asm/pgtable.h
@@ -139,6 +139,7 @@ static inline int pmd_dirty(pmd_t pmd)
 	return pmd_flags(pmd) & _PAGE_DIRTY;
 }
 
+#define pmd_young pmd_young
 static inline int pmd_young(pmd_t pmd)
 {
 	return pmd_flags(pmd) & _PAGE_ACCESSED;
--- a/include/linux/pgtable.h~mm-add-dummy-pmd_young-for-architectures-not-having-it
+++ a/include/linux/pgtable.h
@@ -165,6 +165,13 @@ static inline pte_t *virt_to_kpte(unsign
 	return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
 }
 
+#ifndef pmd_young
+static inline int pmd_young(pmd_t pmd)
+{
+	return 0;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 extern int ptep_set_access_flags(struct vm_area_struct *vma,
 				 unsigned long address, pte_t *ptep,
_

Patches currently in -mm which might be from jgross@suse.com are

mm-add-dummy-pmd_young-for-architectures-not-having-it.patch
mm-introduce-arch_has_hw_nonleaf_pmd_young.patch

--------------u7CXln8IJpfUM7D30HnWCg1x
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------u7CXln8IJpfUM7D30HnWCg1x--

--------------OLFDBcmXh5WgWVzjl1UVlxOV--

--------------EticmVnjzw3LfO3tRKda3OpC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmOAUZAFAwAAAAAACgkQsN6d1ii/Ey+y
QggAg7kel6flCYmKasI5UArDguIKGJeue5kgm40oZjCnWoDAzN93Zn9fPiYdkSjY2SHfpldDxjVC
2JfNyhU03sscEMkMv4AJ8eOLxdoMnz/FYlhVT0Ft2i9iQ/LvyKqIOJ4VClVZA2Oxh4d6rvzZLvJ4
iB8SUa+s+TW+q45tYtXnq+HiCh74CX4LFdB7Rd+vTjt6gSySb6OhhxPJfOlR65+EGNB88rhM2aHf
MBuOj4VZyTs8HJstBL+WlNvwRB8T27p1xcLXvIjBvD06LmqS/Aw0AMpCh8Ty/2rdY389yFEwdh5s
YrwmocyEXX1zG3TEKR1P39k73M8x0wctqmr0k1x+Dg==
=YUMF
-----END PGP SIGNATURE-----

--------------EticmVnjzw3LfO3tRKda3OpC--
