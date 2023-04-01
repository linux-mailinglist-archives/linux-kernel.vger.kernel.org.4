Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E8E6D340D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 23:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjDAVRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 17:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjDAVRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 17:17:54 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108392659D;
        Sat,  1 Apr 2023 14:17:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id dw14so16878903pfb.6;
        Sat, 01 Apr 2023 14:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680383872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/aUE8x/14V3dMRPOVnDZcdRoITdGNMwL8Z4JZeeVb6o=;
        b=P/2/vp/3V0LdJykPEDiqSME92a2SeIhnYBtj97hIgQFYmbRS68KrRXlFlMX7odtq7x
         OfWyne4G1yIXlxT67x+qJIFot3WQ+pYHpXLiwxTzzRpjUkmjoXV+ev7b1+AqWzNpY8Aq
         HcTuT7NjohhI3SmwKqFzaKK6DLBZ8m7BF+r9lSVEQm5x0f/Gz0bccd7gBUsL6qAwwBXH
         oxO6L7pDblZ5RlzBh2NJXCsAvc0UW/aivyCU5lysg7JA43XRQ5kKwlz/1DVL+U6cQ7Gf
         lQo0nxxR87Lx2y+8MgoiLFVer4tvD734MkiKT7YtfDigEIslStRDkRJSnalUF1eeojPT
         F2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680383872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aUE8x/14V3dMRPOVnDZcdRoITdGNMwL8Z4JZeeVb6o=;
        b=uvCGYSyD0zKSnXBmP+va8Qiue8EMqI60epEL/oc/+fpcuRb4cE8cW0/lH4Z7YRa2wc
         wOiFFR18PP3wsQ4zsIyItw+x+Au4gLYPXSxF6HsI251ksTNUEKWNlwfE/Ml/cZKoHDrc
         ls0PdqBKoYfrkBOWH1Zkux9s/r/s0iLTi223H8y7/dheNF0iZUg4iAMOBVQpmF6wi0LR
         3yTKEkvn9pLvVraU6NpMBmTB0Z/KGT0cvOAhPhrdU/a6VO7kiLstU4XcwuOcUqIk+32c
         49mwOfwhbfcoeVt7GDKLOTY/hQBYYi2iZIi27jhpoaZc7H8ZJL4ATl876FAbnqUI5zHT
         wrWg==
X-Gm-Message-State: AAQBX9cqIGmrt9beHrP44KDg/u6Nrzkm4bL8REVQMwBhAb7ZUnWJqhLt
        QkWhTEh7dq1LAOmprsuqxAQ=
X-Google-Smtp-Source: AKy350ZZExF6wfrtRs0ucXe/UzYvAeirB6CVbO2KXFgKqMQGm8wugfaaSVhCuN8bWUzTIVtidyDXqw==
X-Received: by 2002:a62:1948:0:b0:627:f740:51f9 with SMTP id 69-20020a621948000000b00627f74051f9mr14529387pfz.3.1680383872349;
        Sat, 01 Apr 2023 14:17:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:ac04:c59e:2de:5791])
        by smtp.gmail.com with ESMTPSA id y1-20020a056a001c8100b005a90f2cce30sm3970890pfw.49.2023.04.01.14.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 14:17:51 -0700 (PDT)
Date:   Sat, 1 Apr 2023 14:17:48 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        regressions@lists.linux.dev, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] wrong coord from Thinkpad TrackPoint since 6.2
 kernel
Message-ID: <ZCiffEmTSi7aynk5@google.com>
References: <87h6u4otuc.wl-tiwai@suse.de>
 <3dec29bf-b772-d82d-fff9-6c8bcca5f464@redhat.com>
 <874jq3q52i.wl-tiwai@suse.de>
 <87mt3umyui.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt3umyui.wl-tiwai@suse.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 10:23:49AM +0200, Takashi Iwai wrote:
> On Wed, 29 Mar 2023 11:28:53 +0200,
> Takashi Iwai wrote:
> > 
> > On Wed, 29 Mar 2023 11:22:18 +0200,
> > Hans de Goede wrote:
> > > 
> > > Hi Takashi,
> > > 
> > > On 3/29/23 10:16, Takashi Iwai wrote:
> > > > Hi,
> > > > 
> > > > we've received a bug report about Thinkpad TrackPoint (ALPS DualPoint
> > > > Stick) on 6.2 kernel:
> > > >   https://bugzilla.opensuse.org/show_bug.cgi?id=1209805
> > > > 
> > > > The device reports the wrong values as the movements, e.g. sometimes a
> > > > value such as 255, 254 or -255 is returned while usually it should be
> > > > a smaller value like -1 or 2.
> > > > 
> > > > The evtest on 6.2.x kernel shows the wrong values like:
> > > > 
> > > > Event: time 1680037542.898747, type 2 (EV_REL), code 0 (REL_X), value 255
> > > > Event: time 1680037542.898747, -------------- SYN_REPORT ------------
> > > > Event: time 1680037543.145196, type 2 (EV_REL), code 0 (REL_X), value 1
> > > > Event: time 1680037543.145196, -------------- SYN_REPORT ------------
> > > > Event: time 1680037543.175087, type 2 (EV_REL), code 1 (REL_Y), value -255
> > > > Event: time 1680037543.175087, -------------- SYN_REPORT ------------
> > > > Event: time 1680037543.185421, type 2 (EV_REL), code 0 (REL_X), value 1
> > > > Event: time 1680037543.185421, type 2 (EV_REL), code 1 (REL_Y), value -255
> > > > Event: time 1680037543.185421, -------------- SYN_REPORT ------------
> > > > 
> > > > while 6.1.x kernel shows the correct values like:
> > > > 
> > > > Event: time 1680037386.318058, type 2 (EV_REL), code 0 (REL_X), value -1
> > > > Event: time 1680037386.318058, type 2 (EV_REL), code 1 (REL_Y), value -1
> > > > Event: time 1680037386.318058, -------------- SYN_REPORT ------------
> > > > Event: time 1680037386.328087, type 2 (EV_REL), code 0 (REL_X), value -1
> > > > Event: time 1680037386.328087, type 2 (EV_REL), code 1 (REL_Y), value -1
> > > > Event: time 1680037386.328087, -------------- SYN_REPORT ------------
> > > > Event: time 1680037386.338046, type 2 (EV_REL), code 0 (REL_X), value -1
> > > > Event: time 1680037386.338046, type 2 (EV_REL), code 1 (REL_Y), value -2
> > > > Event: time 1680037386.338046, -------------- SYN_REPORT ------------
> > > >   
> > > > I couldn't see any relevant changes in alps.c between those versions,
> > > > so this is likely a breakage in a lower layer.
> > > > 
> > > > Could you guys take a look?
> > > 
> > > I believe this is caused by the kernel now using -funsigned-char
> > > everywhere and this should be fixed by this commit:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?h=for-linus&id=754ff5060daf5a1cf4474eff9b4edeb6c17ef7ab
> > 
> > Ah, that makes sense!
> > 
> > I'll build a test kernel with this fix and ask the reporter for
> > testing.
> 
> And it's confirmed that the commit above fixes the problem indeed.

Sorry for sitting on this, I just sent a pull request and it was merged.

Thanks.

-- 
Dmitry
