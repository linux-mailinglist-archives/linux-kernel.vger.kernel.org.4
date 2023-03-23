Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F7A6C5DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 05:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCWEQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 00:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjCWEQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 00:16:01 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0323035BE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 21:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1679544921; bh=amePZAswCZxnH0HeDHnJFI+gYZgT7zu0jXMkYntGVqE=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=I23woQEI4sc/sCfZ4ELvool5T+tNHo0ty69z/W+kUdjfs/7NROrQIAC4fMANAAlv+
         2X6eXvju2xkd2PtUC/ZLwYJkqNw5TgyDJXXZLfbZJRH40vu+pvjQOb1gOpis/Rvh/i
         BdOtEOuPlzxq1wY8WO772T0Wx+Lq5FUAuu4QYHjU=
Received: by b221-3.in.mailobj.net [192.168.90.23] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Thu, 23 Mar 2023 05:15:21 +0100 (CET)
X-EA-Auth: MqpSBc+VIot+UUjG5z9STlJgrWHjIBGzlEqbIKY79KgmtCwouDOtNFJrNhCxglWEJd+gf/ccKY2TkkvhxmO0sXsACRkL8WTt
Date:   Thu, 23 Mar 2023 09:44:59 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2] staging: most: fix line ending with '('
Message-ID: <ZBvSQxgiFffWsoef@ubun2204.myguest.virtualbox.org>
References: <ZBsYYAc1Ue/JnUAm@khadija-virtual-machine>
 <061a2fea-b3da-551d-f6d2-0da30b0ac879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061a2fea-b3da-551d-f6d2-0da30b0ac879@infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 08:12:23AM -0700, Randy Dunlap wrote:
> Hi--
> 
> And FTR, I still haven't found anything in coding-style.rst that says that
> lines should not end with an open parenthesis.  Did I overlook it?

Hi Randy,
You are correct. I did not find anything clear or obvious that calls out not
ending the lines with a '(' symbol. 
I think the other guideline from the coding style is to align the overrunning
argument list in the next lines such that they match the arg1 after '('. So, I
think that may be the reason why checkpatch is coded to catch such lines.

Regards,
Deepak.

> 
> Thanks.


