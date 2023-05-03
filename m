Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4874F6F5EC1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjECTAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjECTAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:00:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ABD7690;
        Wed,  3 May 2023 12:00:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ab14cb3aaeso15705555ad.2;
        Wed, 03 May 2023 12:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683140440; x=1685732440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TixecA9/pAM4HarsIzbsqo9aEePqi7NlMoMwpBqZ4sg=;
        b=nj0vJNwdVVt0leIQqG7LNcDsn0HBv/2LB5bpwahmUCsC/miRMRioHYtWRmIyKRa4q7
         /LerloBVswHzbFX9CCyUDnpxP/IQ/6PnLLqQpfWnc1NbH+CLoy/qomCuLXbQ/hm7GXbY
         9K1llkLMVIzXH+9erLCPKYeKOCMjPHTi+/CtZTNMV7mXRuC6JsIf5ggN/rnrAz1NhNXa
         eh05/yDdnx52+JINCk6ZeL/o57hnKkS0hVq+XSd3MGLHBk2Mi4AWCPwwxseywCc+V8EF
         Yaorgf1eIpLSqB3Zpcj6GvY7Tq1yLUSj/1p4qXhmSy1aAY4pRffG6YTjpr/A2bnDbK8l
         sQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683140440; x=1685732440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TixecA9/pAM4HarsIzbsqo9aEePqi7NlMoMwpBqZ4sg=;
        b=TaHG4aqH+Cm/jBDGmbBFWxrdk3YZv4kNhts8Ldj6s/L39kekVmjZagdKJi3c5anOuD
         Fy69eLqJ99M8n7IzuFOLg9F8xFliZoDRhTgR/1RDtbXevKQi9VIK+QfG7Z+gTY5abCZ0
         6eIGB2LKsT814hkTtoV+YW+46QV954QRVbd4FOeU6H5CkASLWNXYQWLckgOTLe+nyPyz
         dD/AoNYObQUTCYeTBixSeDz9N5zsROw2ozDoxEksM+Mtt50S2EVk43h3uMx8EbWyv7m8
         nkom+fcIBi+pxDr10qZJ9Sto3WX5TwC77sR+jvixS7eUWgkfajKNVhIiOt2T2JdOHRk1
         3d+Q==
X-Gm-Message-State: AC+VfDxHGIesQO5eCdecst7EbwfRWyiu1d/oMt/6Q3M/a32ojk1GG1M4
        q0w4+1rI6z7CK+YFhFszZ9o=
X-Google-Smtp-Source: ACHHUZ6pUVtfnjx3yCSyP11V3DoOQqy3SF3n3ZcLqHfmDMnSaaQgXO4Z1nHM4fwjQoyk8033mvq5hQ==
X-Received: by 2002:a17:902:b198:b0:1a1:b174:836c with SMTP id s24-20020a170902b19800b001a1b174836cmr1001919plr.16.1683140440270;
        Wed, 03 May 2023 12:00:40 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9390:e396:49ef:54dc])
        by smtp.gmail.com with ESMTPSA id be12-20020a170902aa0c00b001a6a53c3b04sm21958039plb.306.2023.05.03.12.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 12:00:39 -0700 (PDT)
Date:   Wed, 3 May 2023 12:00:36 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Limonciello, Mario" <mlimonci@amd.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-input@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [regression] Bug 217394 - IRQ override skipping breaks the Aya
 Neo Air Plus 6800U keyboard buttons
Message-ID: <ZFKvVKMesT+3NthN@google.com>
References: <01ea5c8e-ed2f-7568-f6ed-896329e7b673@leemhuis.info>
 <68d017d9-d815-01d4-23c1-49c0aaf5f20b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d017d9-d815-01d4-23c1-49c0aaf5f20b@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 11:11:33AM -0500, Limonciello, Mario wrote:
> +linux-input
> 
> On 5/3/2023 7:58 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> > Hi, Thorsten here, the Linux kernel's regression tracker.
> > 
> > I noticed a regression report in bugzilla.kernel.org. As many (most?)
> > kernel developers don't keep an eye on it, I decided to forward it by mail.
> > 
> > Chuanhong Guo, apparently it's cause by a change of yours.
> > 
> > Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
> > not CCed them in mails like this.
> > 
> > Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217394 :
> > 
> > >   Matthew 2023-05-03 02:28:33 UTC
> > > 
> > > Reverting the changes found in this patch fixes the issue:
> > > > https://lore.kernel.org/all/20220712020058.90374-1-gch981213@gmail.com/
> > > With that patch the AT Translated Set 2 Keyboard doesn't show up with the evtest and is not usable.
> > > 
> > > Hardware:
> > > 
> > > Aya Neo Air Plus
> > > AMD Ryzen 7 6800U
> > See the ticket for more details.
> > 
> > BTW: there apparently is another IRQ override needed for a different
> > machine. See https://bugzilla.kernel.org/show_bug.cgi?id=216804#c8 for
> > details (ignore the comments before that, the quirk entry for that
> > machine was merged; comment 8 and all related to it really should have a
> > separate bug; that's also why this partly fall through the cracks here
> > :-/ ). The user is currently trying to create a patch.
> > 
> Something I'm wondering about is if it's possible for i8042 to detect the
> polarity is incorrect when it probes and
> to try to correct it.
> 
> If we could do that we can probably drop 9946e39fe8d0 ("ACPI: resource: skip
> IRQ override on AMD Zen platforms")
> to fix this issue along with all the other quirks that have collected over
> time on i8042 polarity issues.
> 

8042 is shared between multiple platforms and is quite fragile as it is.
If there are issues in AMD firmware and you know the polarity that is
needed for 8042 on these platforms you should add a proper fixup for
override. Maybe you should only skip override for IRQ 1?

Thanks.

-- 
Dmitry
