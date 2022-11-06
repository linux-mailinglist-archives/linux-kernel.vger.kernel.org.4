Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF4161DFEA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 02:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKFBpt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 5 Nov 2022 21:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKFBpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 21:45:47 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5E2FD01
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 18:45:46 -0700 (PDT)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 62AF3A0731;
        Sun,  6 Nov 2022 01:45:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 100341A;
        Sun,  6 Nov 2022 01:44:57 +0000 (UTC)
Message-ID: <9981b20da995772efb0a8593982dbbe32e720355.camel@perches.com>
Subject: Re: [PATCH v2 3/3] staging: rtl8192e: remove unnecesscary macro
 defines
From:   Joe Perches <joe@perches.com>
To:     Jacob Bai <jacob.bai.au@gmail.com>, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Sat, 05 Nov 2022 18:45:41 -0700
In-Reply-To: <Y2cOY/qq8hFrxV+m@jacob-Ubuntu>
References: <cover.1667694826.git.jacob.bai.au@gmail.com>
         <6cdf838429ca9b553fb572f55a53ec25fa4e5f6a.1667694826.git.jacob.bai.au@gmail.com>
         <8fea8008f0ebb85d7e893513117347712e68fba5.camel@perches.com>
         <Y2cOY/qq8hFrxV+m@jacob-Ubuntu>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: hsiec37cdzsbyod93hr1ejkh17d994e8
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 100341A
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18JEex8g4F4OrLF0H9I9j8tXhY/5HeDHiM=
X-HE-Tag: 1667699097-499761
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-11-06 at 12:31 +1100, Jacob Bai wrote:
> On Sat, Nov 05, 2022 at 06:18:41PM -0700, Joe Perches wrote:
> > On Sun, 2022-11-06 at 12:11 +1100, Jacob Bai wrote:
> > > remove useless macro defines
> > []
> > > diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> > > index eabb4187d907..aad1842857c0 100644
> > > --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> > > +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> > > @@ -307,12 +307,12 @@ void rtl92e_config_mac(struct net_device *dev)
> > >  	struct r8192_priv *priv = rtllib_priv(dev);
> > >  
> > >  	if (priv->bTXPowerDataReadFromEEPORM) {
> > > -		dwArrayLen = MACPHY_Array_PGLength;
> > > -		pdwArray = Rtl819XMACPHY_Array_PG;
> > > +		dwArrayLen = RTL8192E_MAC_ARRAY_PG_LEN;
> > > +		pdwArray = RTL8192E_MAC_ARRAY_PG;
> > 
> > Perhaps use ARRAY_SIZE instead.
> > 
> As the other drivers under rtlwifi are using ARRAY_LEN or ARRAY_LENGTH,
> maybe it's better to keep the same format?

Maybe it's better to use the typical kernel style.

$ git grep ARRAY_SIZE drivers/net/wireless/realtek/rtlwifi/
vs
$ git grep ARRAY_SIZE drivers/staging/rtl*

