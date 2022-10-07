Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126BD5F745A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJGGsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJGGsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:48:01 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E894C1DB0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 23:48:00 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id A65D2240104
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:47:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1665125278; bh=0UWS+iyjBP6iUUcWb5qqEtxi5shbZVmZZKIvv3o2RwY=;
        h=Date:From:To:Cc:Subject:From;
        b=kWXsIkCXQzqkU1wY5Iz2vbLfIxBcEwHyxKJR4vzK+pbFBQddApoQRqJm/dNbE32Vg
         A2vhoAOFA0yuFaqnBIS6dSTazEFKRDXwsniKF1idzG5Y6AbHO8zh1heU7suzZjiM4m
         bzzhGv/fCpcbqsMri+tSjgddLXykzWb5g3hVZhtzmdbpMN//MJaKPvrTC0AoTQwn6/
         o7UppGLS89dmdQSy9vBX111ahBhkZD39emxPcR22yTw3gd04Egeye9VFLZsP4KbLOy
         VGLLZLO9F5awdP4a3XpvwHfm4Bv2A0ebd7BZB4h3ZVnoLxvxZuCX0MoGfBT6OvEgxI
         j51D8Me7YZzSg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MkJlx3ydQz6tpg;
        Fri,  7 Oct 2022 08:47:57 +0200 (CEST)
Date:   Fri,  7 Oct 2022 06:47:56 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: fix typo in USB id description
Message-ID: <20221007084756.6f4053c5@posteo.net>
In-Reply-To: <20221005182215.GA2626047@roeck-us.net>
References: <Yzql13NOvQLlrye1@monster.localdomain>
        <20221005182215.GA2626047@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2022 11:22:15 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Mon, Oct 03, 2022 at 09:05:27AM +0000, Wilken Gottwalt wrote:
> > Fixes: 0cf46a653bda ("hwmon: (corsair-psu) add USB id of new revision of the HX1000i psu")
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> 
> Applied. In the future, please add some description (subject is
> insufficient).

Oh sorry. I wasn't sure how to handle this, I mean the title already says all,
nothing more to add.

greetings,
Will
