Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4351B5FDD06
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJMPVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJMPVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:21:18 -0400
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6717510F8A1;
        Thu, 13 Oct 2022 08:21:17 -0700 (PDT)
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
        by wilbur.contactoffice.com (Postfix) with ESMTP id B84E3D55;
        Thu, 13 Oct 2022 17:21:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665674475;
        s=20220911-jt8y; d=wired4ever.net; i=sndanailov@wired4ever.net;
        h=Message-ID:Date:MIME-Version:References:Cc:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=747; bh=kgZc3tu2JJFZWYmDuyz5w4nLD0OZb6n0f9H+SCQhHIY=;
        b=cYTExjZZdbexKtEmSAIkIJrmXWfhg3DlRk8G4pmYviVVOSBahBw/1wCe0IOyxov4
        YM6LpNcixT1l2kdmVBfckf2YPaii/XuZnzz5PIEu9+WNtSgQSyNM4rGhEOrBqyo+Sor
        GCT/wQjDKRWDV3iPVMTWnlGU5q0xPFXROvzBUrMCyQPVC4EiHer9OuGe64VG4+ixJ5W
        eqxjN6bHBkaymbYSeQjN3ssgGZJENCFBCPCKmcFDRVFp6H8RkbwzitYHNc5GtCRJVcH
        iWzQAKv0E4hkwTxlnyI06T4/t47jVvjqEKCZsNMh6KY4D+ms8j7ehgWCp4tfE2QsHvL
        CxLcySd0kA==
Received: by smtp.mailfence.com with ESMTPSA ; Thu, 13 Oct 2022 17:21:12 +0200 (CEST)
Message-ID: <4ec2697e-ddc6-c87a-49a9-12483186af1d@wired4ever.net>
Date:   Thu, 13 Oct 2022 17:21:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] doc: process: add privacy warning when using some SMTP
 servers
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
References: <20221013123115.17419-1-sndanailov@wired4ever.net>
 <8735brkfrj.fsf@meer.lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Sotir Danailov <sndanailov@wired4ever.net>
In-Reply-To: <8735brkfrj.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-ContactOffice-Account: com:378009619
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13 10 2022 15:35, Jonathan Corbet wrote:
> So this seems to be just a description of how email works

Well it felt appropriate to warn the user, because many people
(like myself before) might not realize this is happening even if
they think they know how email basically works.

> the Received headers always show the path through the net.

Yes, but is also dependent on the SMTP server configuration,
so someone might not realize that changing the server would
add such sensitive data to something public.

> Is this really something that we need to cover in the kernel docs?

It's part of the process, is it not? I'm sure many people
would like to have this information before starting on the
kernel for the first time.
