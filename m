Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D4573A6F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjFVRGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFVRGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:06:51 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DB6B7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:06:48 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 2354324002A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 19:06:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687453607; bh=2yrkWe5PjoRhAiyrPn41nPH/DmbJQSKAPmoJHoPXIig=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Transfer-Encoding:From;
        b=js0+gzZfygF4KmpdJukkxv0V4dSah/zz23KA/rfrRIwcvlNq743t73hIddfdGTcba
         KmFkRVqF09Ss43yzvUgD3Cdr9ewvz4ntjJN3ePvo2YoOYcJDbHjrXvkq/VgKamMHUM
         BeulNXUPyQhbBwKLpyKwDlWyaNknvWLvt/LALDOmNjN9jvqwHHC91vSjBL9EL8vZfP
         /2LIXl8gh6JmBOdh8WiJChOG1OXB2u2g0OXjxgycMR9ZMNE+pJSug9FR+sk4E/HCJ0
         PXwz8VbjsdoOHMNi9EkG3GiGkll8XkMJtraTD0oB/SXfV/DcVRcRSMskneHs17Gm7k
         5VgEmyPYt1PFw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Qn6Gt0QPZz6tvC;
        Thu, 22 Jun 2023 19:06:45 +0200 (CEST)
Date:   Thu, 22 Jun 2023 17:06:45 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: add support for reading PWM values
 and mode
Message-ID: <20230622190645.403dd36b@posteo.net>
In-Reply-To: <75153707-e115-d6f8-0f47-ac678aebedd4@roeck-us.net>
References: <ZJP8oSMHCorq9Nql@monster.localdomain>
        <75153707-e115-d6f8-0f47-ac678aebedd4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 07:00:28 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 6/22/23 00:47, Wilken Gottwalt wrote:
> > Also updates the documentation and comments accordingly. Fixes several
> > typos and updates the coding style to be more uniform.
> > 
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> 
> I don't mind minor cleanups combined with functional changes, but this is
> too much. Please split into two patches.

Oh, this is fine. I already spotted another typo in the newly added PWMs in
the documentation.

greetings,
Will
