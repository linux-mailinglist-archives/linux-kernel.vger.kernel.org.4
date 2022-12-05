Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CB664288E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiLEMf2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Dec 2022 07:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLEMf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:35:26 -0500
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C800E1759C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:35:25 -0800 (PST)
Received: from smtpclient.apple ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 2B5CXVWb009741-2B5CXVWd009741
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Dec 2022 20:33:32 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/2] staging: vme_user: fix coding style
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <Y43igvotWRmQzn+e@kroah.com>
Date:   Mon, 5 Dec 2022 20:33:31 +0800
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mingyi Kang <jerrykang026@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Transfer-Encoding: 8BIT
Message-Id: <20D111E5-E0F5-48B4-9391-B4DDDFD4C273@hust.edu.cn>
References: <20221126125642.16358-1-dzm91@hust.edu.cn>
 <20221126125642.16358-2-dzm91@hust.edu.cn> <Y43igvotWRmQzn+e@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 5, 2022, at 20:22, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> On Sat, Nov 26, 2022 at 08:56:34PM +0800, Dongliang Mu wrote:
>> Fix coding style enforced by Linux kernel
> 
> What coding style was changed?  Please always be specific.

The commit message is imprecise. Actually, this patch only fixes the code indentation issue of kfree function call.

Will fix it in v2.

> 
> thanks,
> 
> greg k-h

