Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D756F7FF6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjEEJ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEEJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:27:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8C83C20
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 02:27:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f315712406so91350595e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 02:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683278875; x=1685870875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tG3khmz+PbUqtRe6nuzCK18UTDQxmqQ5JyV5eU/cEaQ=;
        b=YaN4DPMt6ugogOGME6oBtigy2j0IIygV1eXqyQJlKk5EkXDxHAqItp5sSFTyStNqZl
         wbGTdjhP1/WE5EJSY4j4KzW3Tp999avbCpV0TRuC4/BrqR/rlBFoZn4us30/0hxiVzCL
         p77mhMNm8NxGD8iZIj1UvsgpY8s25thExh5qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683278875; x=1685870875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG3khmz+PbUqtRe6nuzCK18UTDQxmqQ5JyV5eU/cEaQ=;
        b=ViePpqNF/PbhUTZyAZGEoSBcG6q4m/BNUuZOio2CJJ2a1Cjzld09lmKn1aIUliyd0N
         UFu6F+RC/HZeVQcx6DJ2pcSrzekeclJzdQ5o2BZZJM0zk6DSahWN5oxHnQpc8T3EOZ8o
         ZA7WMaddPAxdZErbF0Zf5dM0E83XdTCBlQjATXZvyebzAlf7DgI4Re4x736UYnYU0vic
         8rMaOTrbDr08KGg9YQfIhLuTmmUBm9lz+zYLrRbcTIMpxw5c1CpBrU448PaoGbzPwYpA
         y/nly0lA6LG3bPAPx9T6uX5EI9uipP7VtdQEO7FtOJoYIrqmzQKrQLwbdGhFRhx0i3Xq
         zyZQ==
X-Gm-Message-State: AC+VfDwxQytfYNJl1q2adoqdlewKJol03fktYSDKzhsCfdNa9B1MeHVx
        bgLSRJHDdjxwbeG2FH8Q9r0pz0gnHxsERiBLTZY=
X-Google-Smtp-Source: ACHHUZ7VmDpxy51iKFmBgcIzBanKS6A0k5QVsBNNrnddg9+v/l1RbR2aQentuci2hew2P3fMKLTIoQ==
X-Received: by 2002:a5d:5689:0:b0:304:7bbf:7c1e with SMTP id f9-20020a5d5689000000b003047bbf7c1emr4240011wrv.4.1683278874844;
        Fri, 05 May 2023 02:27:54 -0700 (PDT)
Received: from google.com ([37.228.205.50])
        by smtp.gmail.com with ESMTPSA id s7-20020a1cf207000000b003f1733feb3dsm7491394wmc.0.2023.05.05.02.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 02:27:54 -0700 (PDT)
Date:   Fri, 5 May 2023 09:27:52 +0000
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hid-stadiaff: add support for Stadia force feedback
Message-ID: <ZFTMGKwbH2P3uMIp@google.com>
References: <20230403103324.1746758-1-fabiobaltieri@chromium.org>
 <20230413160033.buwdbysbbc2hgu6o@mail.corp.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413160033.buwdbysbbc2hgu6o@mail.corp.redhat.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 13, 2023 at 06:00:33PM +0200, Benjamin Tissoires wrote:
> >  drivers/hid/Kconfig        |   7 ++
> >  drivers/hid/Makefile       |   1 +
> >  drivers/hid/hid-ids.h      |   1 +
> >  drivers/hid/hid-stadiaff.c | 132 +++++++++++++++++++++++++++++++++++++
> 
> Mind renaming this hid-google-stadiaff.c?
> It's hard to know that stadia is from Google otherwise.

Sure thing.

> > +static int stadiaff_play(struct input_dev *dev, void *data,
> > +			 struct ff_effect *effect)
> > +{
> > +	struct hid_device *hid = input_get_drvdata(dev);
> > +	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);
> > +	struct hid_field *rumble_field = stadiaff->report->field[0];
> > +
> > +	rumble_field->value[0] = effect->u.rumble.strong_magnitude;
> > +	rumble_field->value[1] = effect->u.rumble.weak_magnitude;
> > +
> > +	schedule_work(&stadiaff->work);
> 
> It seems weird that you don't have any locking in place here.
> What if you are sending a report (in stadiaff_work) while having your
> _play() function called at the same time?

Yeah you are right, I somehow missed the whole locking story, sending a
v2 with that added.

> > +static void stadia_remove(struct hid_device *hid)
> > +{
> > +	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);
> > +
> > +	cancel_work_sync(&stadiaff->work);
> 
> What if you have a ff play event scheduled right here? Don't you need
> some way of forcing the work to not be scheduled once again?

Good point, adding that as well for v2, took the pattern from other
existing drivers.

Thanks for the review,
Fabio

-- 
Fabio Baltieri
