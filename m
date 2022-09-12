Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEB55B5ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiILRGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiILRGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:06:33 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Sep 2022 10:06:31 PDT
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C653E748;
        Mon, 12 Sep 2022 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2798; q=dns/txt; s=iport;
  t=1663002391; x=1664211991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zg0N9QY1/YwmHwfEqLW7DznXtLlh72g9kNKFhaMXYu0=;
  b=ZW3Pm1QDXC6Rbrf8LoTipwTKlmLMtq2cs3BLkc8R/TR6yGhECG6nFJTi
   eOrOv5vwN942lyykgF+sdD2s3GT2SQXinP+hjmxIVYdFcsTsgZsoWsZwu
   5MzljTZcFC97n4g8ZqNmI0NaBJDoMf/JIeZfSXJOBgJvDp0qUOQn4pzKp
   Q=;
IronPort-Data: =?us-ascii?q?A9a23=3A4OTIM6rduGxxb/a4Ejip94QRdYJeBmKQZxIvg?=
 =?us-ascii?q?KrLsJaIsI4StFCztgarIBmDP/rZZTege9wkbduy8E4Gu5/SzYUyGgBsrSwxE?=
 =?us-ascii?q?CsSouPIVI+TRqvS04x+DSFioHqKZKzyU/GYRCwPZiKa907F3oTJ9yEmj/nVH?=
 =?us-ascii?q?+SkUYYoBwgoLeNaYHZ54f5cs7ZRbr5A2bBVMivV0T/Ai5S31GyNg1aYBlkpB?=
 =?us-ascii?q?5er83uDihhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251?=
 =?us-ascii?q?juxExYFENiplPPwdVcHB++UNgmVgX0QUK+n6vRAjnVtieBga7xNMgEO12jhc?=
 =?us-ascii?q?9NZkL2hsbS8QAEoM6nTkcwWUgJTFGd1OqguFLrvcSDm7pDPlByZG5fr67A0Z?=
 =?us-ascii?q?K0sBqUc++BqESRN+OYeJTQlcB+OnaS1zai9R+0qgd4sROHnMZ0esXx81zzUJ?=
 =?us-ascii?q?egpTIqFQKjQ49JcmjAqiahmB/HUZ4kVdRJsYQ7GbhkJPU0YYLomleG0i33+a?=
 =?us-ascii?q?HtRrk6So6sw/kDQywpqzbzuN5zefdnibctPmVmRoG6A+2XiHjkVMdWezXyO9?=
 =?us-ascii?q?XfEuwNltUsXQ6oIH7G+s/VtmlDWlyoYCQYdUh2wpvzRt6J3YPoHQ2R8x8bkh?=
 =?us-ascii?q?fFaGJSXc+TA?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AqzpPRKgQV5qpuSBDI+sjs1MzqXBQXuEji2?=
 =?us-ascii?q?hC6mlwRA09TyVXra+TddAgpHrJYVcqKRMdcL+7UpVoLUmwyXcx2/h0AV7AZn?=
 =?us-ascii?q?iEhILLFuBfBOLZqlWKJ8S9zI5gPMxbHZSWZuedMbFSt7ec3OF9eOxQueVuN8?=
 =?us-ascii?q?uT9IHj80s=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CMAwBDbIJi/5FdJa1aHgEBCxIMQIF?=
 =?us-ascii?q?EC4Ird1Q9QwOTMYIlA4ETigGFM4EAix0UgWgLAQEBDQEBOQkEAQGBToM0AoU?=
 =?us-ascii?q?+AiU0CQ4BAgQBAQESAQEFAQEBAgEHBIEJE4VoDYZDAQUnEz8QCw4KLiE2BhM?=
 =?us-ascii?q?agmSCYwMxD6tHeIEBMoEBg08BhEmBXwYUEIEYhhaISiccgUlEgRWCczc+giC?=
 =?us-ascii?q?Bax+GVQSOAIdjOwNUgQUSgSFxAQgGBgcKBTIGAgwYFAQCExJTHgITDAocDlQ?=
 =?us-ascii?q?ZDA8DEgMRAQcCCxIIFSwIAwIDCAMCAyMLAgMYCQcKAx0IChwSEBQCBAYNHws?=
 =?us-ascii?q?IAxofLQkCBA4DQwgLCgMRBAMTGAsWCBAEBgMJLw0oCwMUDwEGAwYCBQUBAyA?=
 =?us-ascii?q?DFAMFJwcDIQcLJg0NBBwHHQMDBSYDAgIbBwICAwIGFwYCAnEKKA0IBAgEHB4?=
 =?us-ascii?q?lEwUCBzEFBC8CHgQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxY2GQEFXQYLCSM?=
 =?us-ascii?q?cLAsGBQYWAyZSBiIBlXYIggB7DgUUCBB7ShUEHzWga4IWnT9rg1aBQ4lXlFZ?=
 =?us-ascii?q?LEYNkpGKWZoJKil2UfoRZAgQGBQIWgWE8gVkzGggbFTuCaBM+GQ+XJoVqJDE?=
 =?us-ascii?q?CAQE3AgYLAQEDCY5SgkgBAQ?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="801744397"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 12 Sep 2022 17:05:26 +0000
Received: from zorba ([10.25.129.98])
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 28CH5OBg018035
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Sep 2022 17:05:26 GMT
Date:   Mon, 12 Sep 2022 10:05:24 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: of: overlay: demote message to warning
Message-ID: <20220912170524.GX4320@zorba>
References: <20220907230709.271889-1-danielwa@cisco.com>
 <973f7127-8165-45f6-071f-04360046b7d7@gmail.com>
 <20220908003510.GE4320@zorba>
 <c0c66918-f55e-83e4-edea-b2d32fdb27a7@gmail.com>
 <3fcea82c-f5cf-f066-67b9-08669c44a9c6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fcea82c-f5cf-f066-67b9-08669c44a9c6@gmail.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.129.98, [10.25.129.98]
X-Outbound-Node: rcdn-core-9.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 01:45:40AM -0500, Frank Rowand wrote:
> On 9/8/22 12:55, Frank Rowand wrote:
> > On 9/7/22 19:35, Daniel Walker wrote:
> >> On Wed, Sep 07, 2022 at 06:54:02PM -0500, Frank Rowand wrote:
> >>> On 9/7/22 18:07, Daniel Walker wrote:
> >>>> This warning message shows by default on the vast majority of overlays
> >>>> applied. Despite the text identifying this as a warning it is marked
> >>>> with the loglevel for error. At Cisco we filter the loglevels to only
> >>>> show error messages. We end up seeing this message but it's not really
> >>>> an error.
> >>>>
> >>>> For this reason it makes sense to demote the message to the warning
> >>>> loglevel.
> >>>>
> >>>> Cc: xe-linux-external@cisco.com
> >>>> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> >>>> ---
> >>>>  drivers/of/overlay.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> >>>> index bd8ff4df723d..4ae276ed9a65 100644
> >>>> --- a/drivers/of/overlay.c
> >>>> +++ b/drivers/of/overlay.c
> >>>> @@ -358,7 +358,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
> >>>>  	}
> >>>>  
> >>>>  	if (!of_node_check_flag(target->np, OF_OVERLAY))
> >>>> -		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
> >>>> +		pr_warn("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
> >>>>  		       target->np, new_prop->name);
> >>>>  
> >>>>  	if (ret) {
> >>>
> >>> NACK
> >>>
> >>> This is showing a real problem with the overlay.
> >>
> >> What's the real problem ?
> >>
> >> Daniel
> > 
> > A memory leak when the overlay is removed.
> > 
> > I'll send a patch to update the overlay file in Documumentation/devicetree/ to provide
> > more information about this.  If you don't see a patch by tomorrow, feel free to
> > ping me.
> > 
> > -Frank
> 
> The good news is that your question prodded me to start improving the in kernel documentation
> of overlays.  The promised patch is a rough start at:
> 
>    https://lore.kernel.org/all/20220912062615.3727029-1-frowand.list@gmail.com/
> 
> The bad news is that what I wrote doesn't explain the memory leak in any more detail.
> If an overlay adds a property to a node in the base device tree then the memory
> allocated to do the add will not be freed when the overlay is removed.  Since it is
> possible to add and remove overlays multiple times, the ensuing size of the memory
> leak is potentially unbounded.

Isn't this only a problem if you remove the overlay?

if the dt fixup driver does have the ability to remove the overlay doesn't it
have responsibility to free the memory? Or is it impossible to free the memory?

Daniel
