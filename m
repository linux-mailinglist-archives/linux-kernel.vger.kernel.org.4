Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4335B64AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 02:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIMAwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 20:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiIMAv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 20:51:58 -0400
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E537B7D1;
        Mon, 12 Sep 2022 17:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4633; q=dns/txt; s=iport;
  t=1663030317; x=1664239917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P9F0VVnqIZKUSRkF3utEagp6d//8cizj9m/SBeqTz4E=;
  b=Ka2xKt2HSmsQQFv3tyzXLkATe0yFVcXrjcEI7IlLEwK2yve1S4md3Fa4
   dfTw/4NdoiG5/EwycgUTNBok4cQuOoCF9UZLRGAvtXwMq3Utv16vJCUpS
   aEu/khrJ7ekePutZ8EtKPazzQr+aYvuDqH4KbUPN8Wx0ub/8igbGel5F9
   Y=;
IronPort-Data: =?us-ascii?q?A9a23=3ACGmM+6jwDKZKOgp2Lg34LHYIX1616BIKZh0uj?=
 =?us-ascii?q?C45NGQN5FlHY01jehtvW2nVPqneMGX3KY9wOtu38E9QsMSAmoNhSFE6/yxjQ?=
 =?us-ascii?q?S9jpJueD7x1DKtf0wB+jyH7ockOA/w2MrEsF+hpCC6FzvuRGuK59yMkiPjWH?=
 =?us-ascii?q?uOU5NPsY0ideyc1EE/Ntjo78wIJqtYAbemRW2thi/uryyHsEAfNNwpPD44hw?=
 =?us-ascii?q?/nrRCWDExjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhl?=
 =?us-ascii?q?o/Y1w0mBtXgmbHhfwhTBLXTJgOJzHFRXsBOgDAb+Xd0ifl9ZaFaMBoN49mKt?=
 =?us-ascii?q?4gZJNFluZW2SAotIaTkk+UGWB4eGCZ7VUFD0O+feCni6JPNlSUqdFOpmZ2CF?=
 =?us-ascii?q?noeOYwe5/YyAmxU8/EcAC4CYwrFhO+sxr+/DO52iawLIMT1PYgSpmttwBnHA?=
 =?us-ascii?q?vs8B5POWaPH4ZlfxjhYrtpJF/ada9Yxajd1ahnEJRpVNT8/EJs4gOqsh2K5e?=
 =?us-ascii?q?jtEr1SUorcf4G/V1xF107+rO93QEvSEX8JKl0CU4GbH5HjRDRQTNdjZwj2Am?=
 =?us-ascii?q?k9ALMencTjTQokeEviz8eRnxQTVzW0IAxpQXly+ycRVQ3WWA7p3Q3H4MAJ3x?=
 =?us-ascii?q?UTqyHGWcw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AifsSl618VIKqVNSLy7SlBgqjBIkkLtp133?=
 =?us-ascii?q?Aq2lEZdPWaSKOlfuSV7ZEmPH7P+VQssR4b8+xoVJPsfZqYz+8Q3WBzB8bAYO?=
 =?us-ascii?q?CFggqVxehZhOOI/9SjIU3DH4Vmu5uIHZITNDTYNykcsS4/izPIaurJB7K8gc?=
 =?us-ascii?q?aVuds=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CMAwBDbIJi/5hdJa1aHgEBCxIMQIF?=
 =?us-ascii?q?EC4Ird1Q9QwOTMYIlA4ETigGFM4EAix0UgWgLAQEBDQEBOQkEAQGBToM0AoU?=
 =?us-ascii?q?+AiU0CQ4BAgQBAQESAQEFAQEBAgEHBIEJE4VoDYZDAQUnEz8QCw4KLiE2BhM?=
 =?us-ascii?q?agmSCYwMxD6tHeIEBMoEBg08BhEmBXwYUEIEYhhaISiccgUlEgRWCczc+giC?=
 =?us-ascii?q?Bax+GVQSOAIdjOwNUgQUSgSFxAQgGBgcKBTIGAgwYFAQCExJTHgITDAocDlQ?=
 =?us-ascii?q?ZDA8DEgMRAQcCCxIIFSwIAwIDCAMCAyMLAgMYCQcKAx0IChwSEBQCBAYNHws?=
 =?us-ascii?q?IAxofLQkCBA4DQwgLCgMRBAMTGAsWCBAEBgMJLw0oCwMUDwEGAwYCBQUBAyA?=
 =?us-ascii?q?DFAMFJwcDIQcLJg0NBBwHHQMDBSYDAgIbBwICAwIGFwYCAnEKKA0IBAgEHB4?=
 =?us-ascii?q?lEwUCBzEFBC8CHgQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxY2GQEFXQYLCSM?=
 =?us-ascii?q?cLAsGBQYWAyZSBiIBlXYIgX8BFmUOBRQIECACLitKFQQfNUWgJoIWnT9rg1a?=
 =?us-ascii?q?BQ4lXgkqSDEsRg2SkYpZmgkqKXZR+hFkCBAYFAhaBYTyBWTMaCBsVO4JoEz4?=
 =?us-ascii?q?ZD5cmhWokMQIBATcCBgsBAQMJjlKCSAEB?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="801951762"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 13 Sep 2022 00:51:56 +0000
Received: from zorba ([10.25.129.98])
        by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 28D0prLV020983
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Sep 2022 00:51:55 GMT
Date:   Mon, 12 Sep 2022 17:51:53 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: of: overlay: demote message to warning
Message-ID: <20220913005153.GZ4320@zorba>
References: <20220907230709.271889-1-danielwa@cisco.com>
 <973f7127-8165-45f6-071f-04360046b7d7@gmail.com>
 <20220908003510.GE4320@zorba>
 <c0c66918-f55e-83e4-edea-b2d32fdb27a7@gmail.com>
 <3fcea82c-f5cf-f066-67b9-08669c44a9c6@gmail.com>
 <20220912170524.GX4320@zorba>
 <75e803f8-2b25-22c8-0831-e90d0c889da1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75e803f8-2b25-22c8-0831-e90d0c889da1@gmail.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.129.98, [10.25.129.98]
X-Outbound-Node: rcdn-core-1.cisco.com
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

On Mon, Sep 12, 2022 at 03:32:31PM -0500, Frank Rowand wrote:
> On 9/12/22 12:05, Daniel Walker wrote:
> > On Mon, Sep 12, 2022 at 01:45:40AM -0500, Frank Rowand wrote:
> >> On 9/8/22 12:55, Frank Rowand wrote:
> >>> On 9/7/22 19:35, Daniel Walker wrote:
> >>>> On Wed, Sep 07, 2022 at 06:54:02PM -0500, Frank Rowand wrote:
> >>>>> On 9/7/22 18:07, Daniel Walker wrote:
> >>>>>> This warning message shows by default on the vast majority of overlays
> >>>>>> applied. Despite the text identifying this as a warning it is marked
> >>>>>> with the loglevel for error. At Cisco we filter the loglevels to only
> >>>>>> show error messages. We end up seeing this message but it's not really
> >>>>>> an error.
> >>>>>>
> >>>>>> For this reason it makes sense to demote the message to the warning
> >>>>>> loglevel.
> >>>>>>
> >>>>>> Cc: xe-linux-external@cisco.com
> >>>>>> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> >>>>>> ---
> >>>>>>  drivers/of/overlay.c | 2 +-
> >>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> >>>>>> index bd8ff4df723d..4ae276ed9a65 100644
> >>>>>> --- a/drivers/of/overlay.c
> >>>>>> +++ b/drivers/of/overlay.c
> >>>>>> @@ -358,7 +358,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
> >>>>>>  	}
> >>>>>>  
> >>>>>>  	if (!of_node_check_flag(target->np, OF_OVERLAY))
> >>>>>> -		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
> >>>>>> +		pr_warn("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
> >>>>>>  		       target->np, new_prop->name);
> >>>>>>  
> >>>>>>  	if (ret) {
> >>>>>
> >>>>> NACK
> >>>>>
> >>>>> This is showing a real problem with the overlay.
> >>>>
> >>>> What's the real problem ?
> >>>>
> >>>> Daniel
> >>>
> >>> A memory leak when the overlay is removed.
> >>>
> >>> I'll send a patch to update the overlay file in Documumentation/devicetree/ to provide
> >>> more information about this.  If you don't see a patch by tomorrow, feel free to
> >>> ping me.
> >>>
> >>> -Frank
> >>
> >> The good news is that your question prodded me to start improving the in kernel documentation
> >> of overlays.  The promised patch is a rough start at:
> >>
> >>    https://lore.kernel.org/all/20220912062615.3727029-1-frowand.list@gmail.com/
> >>
> >> The bad news is that what I wrote doesn't explain the memory leak in any more detail.
> >> If an overlay adds a property to a node in the base device tree then the memory
> >> allocated to do the add will not be freed when the overlay is removed.  Since it is
> >> possible to add and remove overlays multiple times, the ensuing size of the memory
> >> leak is potentially unbounded.
> > 
> > Isn't this only a problem if you remove the overlay?
> 
> Yes, but we don't know if the overlay will be removed.  And I will not accept a
> change that suppresses the message if there is no expectation to remove the
> overlay.
 
I haven't researched the whole overlay system but there was one removal function
that I noted, I think in the link you provided above, called
of_overlay_remove(). It appears to call free_overlay_changeset() which calls kfree().

so your API seems to deal with freeing the memory. I would think the expectation is that
people using the API would free the overlay thru your API.

The only in tree usage of your API (besides the unit test) was drm/rcar-du which
had no ability to remove the overlay that I can see. That component of the driver was
removed several months ago.

> > 
> > if the dt fixup driver does have the ability to remove the overlay doesn't it
> > have responsibility to free the memory? Or is it impossible to free the memory?
> 
> It is difficult due to architectural issues.  Reference counting occurs at the node
> level, and not at the property level.  So memory related to properties is freed
> when the corresponding overlay node reference count leads to the node being freed.

How does of_overlay_remove() work then? It seems like it might not be possible
to do overlay removal, but your code has removal functions. I also see this one
of_overlay_remove_all() ..

It seems like your API supports removal. Is there an issue where your API is
maybe not complete or maybe doesn't currentily work ?

Maybe you could add a flag or other indicator which would indicate the overlay will never be
removed. Then your code could rely on this property to inform on if the author
has consider the removal issues related to overlays.

Daniel
