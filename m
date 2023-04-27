Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287CD6F00B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbjD0GTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjD0GTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:19:10 -0400
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45054497
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 23:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=equiv.tech;
        h=from:subject:references:mime-version:content-type:in-reply-to:to:cc:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=org; bh=n656G4esSAOZGJcBaYYx7683DU+LhAvrzMnNxEqS7gQ=;
        b=UqAEt4SlXWMuc9VkPymjMNY/VVT2pDldBzFFvjZuCVNgdasILd3remnQtl9gBxGv6uZb
        XMfDHFulvRcutt5kwYQI4gcvyM6Hj1KBEnqNnbbXZW8SI+vguqMwVXgg7+oI/zydHrxHQH
        C4yBNr+1utryQcNUCxqnaSGlzvxvR+7rM=
Received: by filterdrecv-5848969764-8hxzr with SMTP id filterdrecv-5848969764-8hxzr-1-644A13DC-1A
        2023-04-27 06:19:08.792812947 +0000 UTC m=+147509.940676531
Received: from localhost (unknown)
        by geopod-ismtpd-2 (SG) with ESMTP
        id 56X96kKyTIiaBkFh5O1TSQ
        Thu, 27 Apr 2023 06:19:08.588 +0000 (UTC)
Date:   Thu, 27 Apr 2023 06:19:09 +0000 (UTC)
From:   James Seo <james@equiv.tech>
Subject: Re: [RFC v2 1/2] platform/x86: wmi: Allow retrieving the number of
 WMI object instances
Message-ID: <ZEoT3LCzSweokbt8@equiv.tech>
References: <20230426212848.108562-1-W_Armin@gmx.de>
 <20230426212848.108562-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426212848.108562-2-W_Armin@gmx.de>
X-SG-EID: =?us-ascii?Q?1X41iaRO4wVP+tFXGLuxpQ0yxxMDhGIesR5UcsYKVengQKgidLJSXwOMZlPQwP?=
 =?us-ascii?Q?WswkK2aiXBW+21Rohn5GJrNqDc3RLX6sG4PuoFI?=
 =?us-ascii?Q?ERuyIxGPPrWGjVaHdG1VAzJ+W+Qk8ld5GvRjtp+?=
 =?us-ascii?Q?TTEX+MRLVk0A=2F6a9w1aEbYVhI8AWZUPZka6lIIO?=
 =?us-ascii?Q?3oKxaLv5HLwHxqJ=2FCv=2FwWdYM74Al5hb9kjaJ9Kt?=
 =?us-ascii?Q?GNjMX8wtSJGpmy8sBCguTiefR1LQmHAmCASTyu?=
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        Mario.Limonciello@amd.com, prasanth.ksr@dell.com,
        jorgealtxwork@gmail.com, james@equiv.tech,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Entity-ID: Y+qgTyM7KJvXcwsg19bS4g==
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 11:28:47PM +0200, Armin Wolf wrote:
> Currently, the WMI driver core knows how many instances of a given
> WMI object exist, but WMI drivers cannot access this information.
> At the same time, some current and upcoming WMI drivers want to
> have access to this information. Add wmi_instance_count() and
> wmidev_instance_count() to allow WMI drivers to get the number of
> WMI object instances.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Tested-by: James Seo <james@equiv.tech>
