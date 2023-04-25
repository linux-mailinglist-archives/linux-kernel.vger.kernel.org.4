Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BA36EDEB0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjDYJFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbjDYJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BCB10FE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682413493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J2xcNS6yIqjGNizC3DyLZ1+7mKm7C0C6L/r+oz7cqk4=;
        b=KRZXrXFcEbbk7Dgt6GYjx6QGGl67XvMnCLnk5IKeHS6JzskaCMQTDf6RPeHpSh9yQjuPdc
        TSCDTlr8c83StIiwK0aVGRym5siXZGd6fMgcCip3g91/xjzV8lixIEO+ksAnsil8IoiTwC
        bo0PyIEV9lF7k3cAmV6jTqrm9Yu1T+Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-5vXnxFhyPEWgos0wcVILAA-1; Tue, 25 Apr 2023 05:04:48 -0400
X-MC-Unique: 5vXnxFhyPEWgos0wcVILAA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CA9A800047;
        Tue, 25 Apr 2023 09:04:47 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.45.227.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45F7040C2064;
        Tue, 25 Apr 2023 09:04:46 +0000 (UTC)
Date:   Tue, 25 Apr 2023 11:04:43 +0200
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Mubashshir <ahmubashshir@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Huseyin BIYIK <huseyinbiyik@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v3] staging: HID: Add ShanWan USB WirelessGamepad driver
Message-ID: <udogxn4kbihht7isswwwofra373lotxtfvyj7kwxbe3436fjsp@4yxggpana75c>
References: <39b44678dc54b519fa469b69d80757b36ab3cf25.1681118245.git.ahmubashshir@gmail.com>
 <fd1961a773558930b6ae0aa2f6fc7f84833ee634.1681131540.git.ahmubashshir@gmail.com>
 <20230413161305.ywthwbu3ta3mv66b@mail.corp.redhat.com>
 <3ONCTR.Q80RY3TDW2I8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ONCTR.Q80RY3TDW2I8@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 19 2023, Mubashshir wrote:
> On Thu, Apr 13 2023 at 06:13:05 PM +02:00:00, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > What's the point of keeping it opened for the lifetime of the device? Do
> > you really need this?
> > 
> > >  +	if (error) {
> > >  +		dev_err(&hdev->dev, "hw open failed\n");
> > >  +		hid_hw_stop(hdev);
> > >  +		return error;
> > >  +	}
> > >  +
> > >  +	return 0;
> > >  +}
> > >  +
> > >  +static void shanwan_remove(struct hid_device *hdev)
> > >  +{
> > >  +	hid_hw_close(hdev);
> > 
> > If you can drop the last hid_hw_open/close, then you can entirely skip
> > the ->remove().
> 
> Would hid_hw_request work without open device?

No, it won't work if the device is not opened. But what's the point of
sending rumble data to the joystick if the device is not opened (so used)
by anybody? open() is called whenever a client opens the device, by
accessing the evdev node, so I think it should be fine.

Cheers,
Benjamin

