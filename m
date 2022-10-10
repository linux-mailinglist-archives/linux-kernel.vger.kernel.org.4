Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A0D5F9722
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 05:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiJJDHf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Oct 2022 23:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJJDH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 23:07:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B7E51A3E
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 20:07:27 -0700 (PDT)
X-QQ-mid: bizesmtpipv602t1665371237tfwd
Received: from SJRobe ( [255.214.198.8])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Oct 2022 11:07:16 +0800 (CST)
X-QQ-SSF: 01100000000000G0Z000000A0000000
X-QQ-FEAT: ALw5QuVtm4UUWj0CO5GaAjBOXlBi7+sQydDZSse1twnd4Bdo2v9zhaTHHoA2g
        qIKB20Y1I5fOXYDGvE8LJbA/tXi+rFxGjFjmmvHnQnBnrzsiZDo58ygmNwMKOZ0XrTmIACI
        audKAkCw04+PUx43FiFHQB8N/P6mqSBwzLDbdvgyGUL8qS4V/KttB/A+Vqbbo9ZY4Diqlcl
        wJ8FHMkBBH6IbMgYPtsTmQqNU/5JO8IfMjxCN7MtA0zrkDf0EfLTqCla5OkqrLK/dOSL15R
        wVt3w5rdL/RmlndU7qoxu04d9vAo/VI72xFMc2TobGDuhNyrBfA+NcBIqxDmPh84Dw4mDS1
        Z9G4Q365G2Nzis3wLp8TjJoImgwmMoRiizxT0JrhVldXSQQ7JvMLSOYZvy2gg==
X-QQ-GoodBg: 0
From:   "Soha Jin" <soha@lohu.info>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        "'Daniel Scally'" <djrscally@gmail.com>,
        "'Heikki Krogerus'" <heikki.krogerus@linux.intel.com>,
        "'Sakari Ailus'" <sakari.ailus@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20221009162155.1318-1-soha@lohu.info> <Y0MRxgKhRVbyrTz2@kroah.com>
In-Reply-To: <Y0MRxgKhRVbyrTz2@kroah.com>
Subject: RE: [PATCH 0/3] Case-insensitive match_string and fwnode_is_compatible()
Date:   Mon, 10 Oct 2022 11:07:13 +0800
Message-ID: <1BF643A9A697B323+1bc601d8dc55$65ae1cf0$310a56d0$@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ3YxYd+FPcuiJVmWEOx+0wAFDAtAKnp80RrLSmI+A=
Content-Language: fr
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:lohu.info:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> 
> On Mon, Oct 10, 2022 at 12:21:52AM +0800, Soha Jin wrote:
> > I am introducing these patches for the patch for ethernet driver which
> > I will send later.
> 
> We can't take functions that have no real users.  Please send these patches
> as part of your driver submission so we can see how they are used and if they
> are even needed at all.
> 

This is the first time I submit patches to kernel, I am sorry for anything
wrong I did.

I am just thinking these patches and the driver patches are in different
trees, so I split the patches into different parts. The driver patch is at
https://lore.kernel.org/all/20221009162247.1336-1-soha@lohu.info/.

Regards,
Soha

