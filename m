Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E40C6EDEB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjDYJGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjDYJGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:06:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B8C3;
        Tue, 25 Apr 2023 02:06:51 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24781e23c27so5026331a91.0;
        Tue, 25 Apr 2023 02:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682413611; x=1685005611;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4SiGTTRIlPdDqLy+w/LHSk/EupbIUpByuZb+REdhLgw=;
        b=RazNFRctLYaHyyol5MSSdprX2tKekP5EF7U3Rpz4C2zcSCMwgUUBxJh+K46pzz1eIr
         brmR07zaGGOtn/lPhTTICV3FpGHVdi99ocsJx3nPUNDnLapbvYecIHa4UQME8k8fCTo8
         KQs9N/lFYh2GtWazoh6FldIfd3L6Uz0YC9+ej9a31hXhqjHLdHMNhK4edGSC61d3r7Xy
         P/jAdXypiO8flpYI97FfBpRHHUwjhxAo844KHnP3h5VIeOj+YHDJx7LA0vX6x4F5oWgo
         tHKeiNyQJ5fIu6M1DyGCArcp+PklhZAEqIhbtwabvV96MB6LF+CmmiyeTlUFAzdapnr5
         hwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682413611; x=1685005611;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4SiGTTRIlPdDqLy+w/LHSk/EupbIUpByuZb+REdhLgw=;
        b=AiGpKPpO0sRAHkHH6olZvzIcOPwKYhODslGh+eAiGdxAH6FaxldapmuvGDQmN5OvaY
         juyVndo2Jf3Btw0OQMtgUAsRzsw9zh3gLM+MlAo8EupwEREz49GQMP8vKNcFtrBUcXnr
         Er1YEqAS6yzwtfNRtSnAB7w2Cqt3pq3OSnCaXTqFvojmw8MXPTG0+JcuWSwbEn4PsLP5
         5o1sjt4l1VBMIONjkJE1YyCVAc3mVzaNRa779MSdg01EPJY84B31HQqViZqun3c/2QCs
         fO5RzUh7egxbeRnJRvQO4VnIuvdu+F2t+DlPkPkYgjr4Th9w+sEL7oDQSCWl7JSXFLZ/
         O9PA==
X-Gm-Message-State: AAQBX9fPcyXc+HKo3qVtLHqmwNlqoZWnwOyCDKIGlCiyy1h+Z+J1hZf3
        D2pkcnOBF5svKl6arKSe2DcpCprZFa+XsQ==
X-Google-Smtp-Source: AKy350Y6kV2DKkDDqRgT8QOhROkxhWSUe5IZT44N/xQDymiLHxJLmL6za2OmCAiHu2faNdQwP7MOYw==
X-Received: by 2002:a17:90a:ff03:b0:247:78eb:cb96 with SMTP id ce3-20020a17090aff0300b0024778ebcb96mr16034820pjb.17.1682413610848;
        Tue, 25 Apr 2023 02:06:50 -0700 (PDT)
Received: from [192.168.127.3] ([103.133.200.235])
        by smtp.gmail.com with ESMTPSA id lx3-20020a17090b4b0300b00246cc751c6bsm9412423pjb.46.2023.04.25.02.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 02:06:50 -0700 (PDT)
Date:   Tue, 25 Apr 2023 15:06:40 +0600
From:   Mubashshir <ahmubashshir@gmail.com>
Subject: Re: [PATCH v3] staging: HID: Add ShanWan USB WirelessGamepad driver
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Huseyin BIYIK <huseyinbiyik@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Message-Id: <4NYNTR.G6KR4F80LHDT2@gmail.com>
In-Reply-To: <udogxn4kbihht7isswwwofra373lotxtfvyj7kwxbe3436fjsp@4yxggpana75c>
References: <39b44678dc54b519fa469b69d80757b36ab3cf25.1681118245.git.ahmubashshir@gmail.com>
        <fd1961a773558930b6ae0aa2f6fc7f84833ee634.1681131540.git.ahmubashshir@gmail.com>
        <20230413161305.ywthwbu3ta3mv66b@mail.corp.redhat.com>
        <3ONCTR.Q80RY3TDW2I8@gmail.com>
        <udogxn4kbihht7isswwwofra373lotxtfvyj7kwxbe3436fjsp@4yxggpana75c>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25 2023 at 11:04:43 AM +02:00:00, Benjamin Tissoires 
<benjamin.tissoires@redhat.com> wrote:
> No, it won't work if the device is not opened. But what's the point of
> sending rumble data to the joystick if the device is not opened (so 
> used)
> by anybody? open() is called whenever a client opens the device, by
> accessing the evdev node, so I think it should be fine.

I'll test it tonight...


