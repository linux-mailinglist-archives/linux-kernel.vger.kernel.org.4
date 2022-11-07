Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFDB61FE0A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiKGS6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiKGS55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:57:57 -0500
X-Greylist: delayed 115448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 10:57:27 PST
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C948329811;
        Mon,  7 Nov 2022 10:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667847432; bh=k0P8ZE+uqQGVs6wL7Q7U7sf2vt2NmAe+s9GmSscWQ0c=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=eC9931eWOAk5D6YxDQdpohg9OWEYrmGecMyIJrZLxY2yaxzl/anSb3ebTj7ejMDgs
         R2VDj5avBMf4HqebeaDNc/39cJTs8lVTmC6KZ1qM8kGfRs1YHOoCWxUfKCvrTWc7nl
         j8atkUi9WqzVKfpAaso6Dl9riohSOImjHlqKpELM=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon,  7 Nov 2022 19:57:12 +0100 (CET)
X-EA-Auth: uJYbcnbU7/Gnv/kEAbQmGdQCJ/olU5GTMJpo6jMiKW/YsivpNT2VbpYQVLnhqIqXLpu6xC/hldMuQtAOfKssKWdyCKfS7j0U
Date:   Tue, 8 Nov 2022 00:27:03 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: patches for staging:media drivers
Message-ID: <Y2lU/78ZFoVElIp4@qemulion>
References: <Y2eSCZJNWn6DzCUu@qemulion>
 <48f4bda9-b5e3-9649-aab9-b529889bf110@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48f4bda9-b5e3-9649-aab9-b529889bf110@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 06:29:30PM +0100, Neil Armstrong wrote:
> Hi,
>
> On 06/11/2022 11:52, Deepak R Varma wrote:
> > Greetings to all.
> > My name is Deepak R Varma and I was part of the recent Outreachy internship
> > round. I learned during this program that patches for the media drivers were
> > prohibited to be included in the Outreachy effort due to lack of bandwidth for
> > the maintainers to respond on those.
> >
> > The Outreachy round is now over but I am continuing to work on code improvement
> > and changes. I would like to know if it is okay for me to now identify
> > opportunities in the media drivers and send patch proposal for your kind
> > consideration. I intend to send couple of Coccinelle identified code
> > improvements as patches.
> >
> > Please let me know.
>
> I won't say no but since the media maintainers will need to apply them,
> the problem is the same.

Hello Neil,
Thank you for responding. I will send in the patches. I am sure they will be
reviewed at an appropriate time and responded accordingly.

Have a good day!
./drv

>
> Neil
>
> >
> > Thank you,
> > ./drv
> >
> >
>
>


