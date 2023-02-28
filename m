Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12DB6A5F93
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjB1TYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB1TYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:24:04 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE41EB5F;
        Tue, 28 Feb 2023 11:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b7Pz70V3Wp1wfqmuX0LHHPAtg3B7CtJzjAn7td+NccI=; b=jl/oNKF/mpl4hwO0zdIYz047xh
        l5lQhLpcFbyXFq/RMlQTXTD/SRFMa/UIX+53eYe5SlNibupvgmqCMnAYDDQwh4B8kEWEyJOwPeKLk
        RCibbGs49SL10D8y4O8WO4phCfoUzGz9kT1BXtfw/Pnp9aqUDXyxRSwQEiezEwhwn9dTV7dCzRkwg
        qd5rJdvsEvjpp3cA+ssR0GWWJUd2KQKeGEbM3vaVvcv/epdKh7EENxz6ONekqP+HNGlsrrCcTv40n
        HNSVLvewkqWmCCEhI9Vz+wOs0R0JeVpKTB1BS8zpm+8FPg3rKuV1wnOlPv7H/9wZJ+RQjfAqssS3D
        bhyL2bIA==;
Received: from [152.254.196.162] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pX5Zr-000YqE-1u; Tue, 28 Feb 2023 20:23:56 +0100
Message-ID: <c4a10a43-1a17-a91d-30ea-eaf549b22103@igalia.com>
Date:   Tue, 28 Feb 2023 16:23:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] parisc: Replace regular spinlock with spin_trylock on
 panic path
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeroen Roovers <jer@xs4all.nl>
References: <20230220211105.151401-1-gpiccoli@igalia.com>
 <9b75b8ec-4006-9606-2db4-e1ad5a0b3f8d@gmx.de>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <9b75b8ec-4006-9606-2db4-e1ad5a0b3f8d@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 15:45, Helge Deller wrote:
> [...]
> Thank you Guilherme!
> 
> I've now picked it up in the parisc-for-next tree.
> 
> Helge

Thanks a lot Helge, much appreciated!
Cheers,


Guilherme
