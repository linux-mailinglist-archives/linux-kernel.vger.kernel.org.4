Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968345E565A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 00:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIUWvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 18:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIUWv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:51:28 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FC09F779;
        Wed, 21 Sep 2022 15:51:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id l10so7078619plb.10;
        Wed, 21 Sep 2022 15:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9JrXwkZGbgGFgV5RiW5DOnS9oCj7thmky0a5QTHjXmU=;
        b=S+tFxGlXbOmfAW7McAnz/WkhfI+esZUdWhdQPJMhzbijr1HBuyJe1E1L0lbdBtoNZ5
         akdwC2ACe7RMKHhjttsLvsWv+QAQuIs09L9wHGWb2ANCyXOjxehNGgoXC6+3wfzEuJL2
         0ZV+b2+FqBMskSpVlkKA3xeU7fdDcQiC3HCG+zFcIVvrVAgKnwOAFuLYbzUsVxHZgDFZ
         TKee1PvdeVBAaq+N6yr/NvbclB5yor1mbgdJ+P/fxZYv/jWixXqLXSWLFJh/BzU/tucd
         izZc37EbvwgES8EwvtB3kHSCncAsZaFg2jcM7PfXZ/JtMEB0EcHFKW6zzGMVp8FVEFFX
         GmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9JrXwkZGbgGFgV5RiW5DOnS9oCj7thmky0a5QTHjXmU=;
        b=oyRG/NaS3a8HpkVthOqqiGVnzhn4wLIy5Xb/uovaMTTFXMeSlvDEVWv3bu4hvpyPfU
         pIVvHZXwK5p6IpcwB1TmGU4erQDQHuC7khNkXqXuhtQuE3n5tmvGgGDPqEamV/2hx6zu
         6ovTQSmnzkm5Qgdy9qF6GFSC8XUwn5T4ox1oHeXuQuqZ0VD/5Wptx00vE0+8yYqmEVhS
         iluqTL69EbZAJJDUPykvHb3H2quGOWvv7h3Dtm/CweVJYEHuVm7N/LPomKKIsLe+wjOy
         E0JuE3vovQt9/fTgfmwnCYsUmMlu19sWV9s9Dc2svXvhSKfQOxKe8w8XMM/43L4NND+Z
         0NCw==
X-Gm-Message-State: ACrzQf1LoPPev6azsNX8/a2WF4bsnlSWBlNWIiO4RdG5kfKjMrpV9/nl
        827MeImBNfOxF2K4cO6lb2s=
X-Google-Smtp-Source: AMsMyM75TwwQt3SFzkc4i0rX48NOjCni8zR0dNfbHGVRvOEqjPTgHXfSyfTOvkF580MoSQTiJKip2Q==
X-Received: by 2002:a17:90b:1b07:b0:203:5860:b441 with SMTP id nu7-20020a17090b1b0700b002035860b441mr11895550pjb.103.1663800687655;
        Wed, 21 Sep 2022 15:51:27 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:24df:bb59:8f79:12a6])
        by smtp.gmail.com with ESMTPSA id z4-20020a1709027e8400b00177e5d83d3dsm2541172pla.170.2022.09.21.15.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:51:27 -0700 (PDT)
Date:   Wed, 21 Sep 2022 15:51:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     margeyang <marge.yang@synaptics.corp-partner.google.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, dancarpenter@oracle.com,
        marge.yang@tw.synaptics.com, derek.cheng@tw.synaptics.com,
        vincent.huang@tw.synaptics.com
Subject: Re: [PATCH V4] HID: HID-rmi - ignore to rmi_hid_read_block after
 system resumes.
Message-ID: <YyuVbPOt3Iul7s/Y@google.com>
References: <1660559178-5323-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
 <20220921151143.xrchxekzqrgqlujv@mail.corp.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921151143.xrchxekzqrgqlujv@mail.corp.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Wed, Sep 21, 2022 at 05:11:43PM +0200, Benjamin Tissoires wrote:
> On Aug 15 2022, margeyang wrote:
> > From: Marge Yang <marge.yang@synaptics.corp-partner.google.com>
> > 
> > The interrupt GPIO will be pulled down once
> > after RMI driver reads this command(Report ID:0x0A).
> > It will cause "Dark resume test fail" for chromebook device.
> > Hence, TP driver will ignore rmi_hid_read_block function once
> > after system resumes.
> > 
> > Signed-off-by: Marge Yang<marge.yang@synaptics.corp-partner.google.com>
> > ---
> 
> I have fixed your signed-off-by line by adding a space between your name
> and address, and converted the C++ style comments into proper multiline
> comments, and applied to for-6.1/rmi in hid.git
> 
> Sorry for the delay, this one went through the cracks.

I think we are rushing with this. There are questions whether the ACPI
data for the device is generated properly and also whether we should be
smarted when counting wakeup events in case interrupt that is
potentially wakeup-capable  happens in the middle of the resume process.

The patch is not a fix for behavior that affects users, but rather a
band-aid to appease a Chrome OS test, which is IMO is a weak reason for
accepting the patch.

Thanks.

-- 
Dmitry
