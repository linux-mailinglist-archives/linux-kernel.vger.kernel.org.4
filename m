Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5A274780D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjGDRw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGDRwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:52:25 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EED10C8;
        Tue,  4 Jul 2023 10:52:23 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666edfc50deso3735533b3a.0;
        Tue, 04 Jul 2023 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688493143; x=1691085143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zx2d7UDCLbvQS87NHg+mG17/iijsxJufJo4WISm7E0o=;
        b=O8StYMRbijI6xBMOu87q2uUaXOGqg1z8qUSCHH1Cyxr30oXZExWo1IkI1FMsAgT4X0
         NHm/CR4ABJ5aPuwZrudEytGCHp/Thm98KxEdp5c8gOPrf1w0BoN8IR3q9FWgQiQlO1K3
         tHzpKnZc1FC6lIcGtMU0w7nP6v5emLK10f/wqc5vLPTtteXnNbD9EplzHCuJV4pFvET7
         FtFbO1Mtp8EC9KvmasU9PWY9Bz0i1Wo7LwesrtPgeQGVNqclfSGieDs+C1vZYS/zuWDQ
         G0v2SOSh42LYDxX3fVHLPDW1PDnS4AyPq7wg2XA1n1/F1HOh+I+yMqdd/IqxapRtmS9t
         THng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688493143; x=1691085143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zx2d7UDCLbvQS87NHg+mG17/iijsxJufJo4WISm7E0o=;
        b=ec/lRpvtVo5aI99gM+qlMEXMXv53FYa60m4PA3TRXF0Etg7LC7Lcm+7xiW+VLvPPYv
         ynpN46xlFiVSNdX+miZuq1JDbFQVBfNHrGZS8UgiYsWyDSkDx5ENSvtuq1E+FL621VsX
         cXJrImLV0KmwLIRuINXPjv/MIa/OM/AnLGHZ370ueIN3237uJ0kmYAxdYZObrBU9CQxj
         2SNFpTF8jZ3nXcACHU7cE8x0C90H+5kf1kPC8ybePIibGxMYfhJEQQAAk/xP5Sr6E97Z
         EPJDiSc9zNJdd5GhnL51PwllglVJ/ohKfj3l/MePKxdsNGJY4aD6jFxlPQmEAr7fVslJ
         2m3A==
X-Gm-Message-State: ABy/qLbDDMsvZ9ZpJMuZPHOhLcy2H21Zy6VssCVKlXrWT5vVFAox3cqg
        pyKJ8luCxhp5XzQ2+nJ1ZLE=
X-Google-Smtp-Source: APBJJlHhrt7o+rOCUD/1BK3I6v798WMkYHj/VJNK4liwSQFR+R5uWjrjXIxqsQIHouyrPKa6UMuN7g==
X-Received: by 2002:aa7:9acf:0:b0:682:5e8f:d8ba with SMTP id x15-20020aa79acf000000b006825e8fd8bamr18737082pfp.11.1688493142783;
        Tue, 04 Jul 2023 10:52:22 -0700 (PDT)
Received: from yoga ([2400:1f00:13:4ede:83d1:b57d:fa38:7670])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78c04000000b006765cb32558sm14057671pfd.139.2023.07.04.10.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 10:52:22 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Tue, 4 Jul 2023 23:22:14 +0530
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
Message-ID: <ZKRcTqAsKxF/Q3fQ@yoga>
References: <ZHkEWse0NVZhwKR7@yoga>
 <ZH5YBBWW5ANckoMp@yoga>
 <CAP-5=fU7ukrQSh_8OwH9C+a-EwCamCrMaZxjqDhE9f+bFJwQBQ@mail.gmail.com>
 <ZIHPXV5/ZopqcSSc@yoga>
 <ZIofrGKElc3nkNk0@yoga>
 <CAP-5=fV9tXNpYHH9DW0cVbRoFLGvG9SNn-MUhuyKuVBRuDqjoA@mail.gmail.com>
 <ZJyT8bt0LFLw6hKV@yoga>
 <CAM9d7ch7TdagV+dzj6MCp4fY15Vc4oGJjKAoQDyc=BXqy7qi+A@mail.gmail.com>
 <287bf3c8-fa0e-8c36-df14-7d728c63c265@intel.com>
 <ZKQu00bJZwO+Fc6m@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZKQu00bJZwO+Fc6m@yoga>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 08:08:11PM +0530, Anup Sharma wrote:
> On Thu, Jun 29, 2023 at 09:35:22AM +0300, Adrian Hunter wrote:
> > On 29/06/23 09:26, Namhyung Kim wrote:
> > > Hi Anup,
> > > 
> > > On Wed, Jun 28, 2023 at 1:11 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> > >>
> > >> On Wed, Jun 14, 2023 at 01:17:52PM -0700, Ian Rogers wrote:
> > >>> On Wed, Jun 14, 2023 at 1:14 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> > >>>>
> > >>>> On Thu, Jun 08, 2023 at 06:23:49PM +0530, Anup Sharma wrote:
> > >>>> I wanted to take a moment to provide you with an update on the progress
> > >>>> of our Firefox Gecko converter work. While I must emphasize that the code
> > >>>> I'm sharing is not the final version, I wanted to share the advancements
> > >>>> I have made thus far.
> > >>>>
> > >>>> This script can generate a JSON format from the output of the "perf script" command.
> > >>>> I attempted to load this JSON file into profile.firefox.com, and although it
> > >>>> successfully loaded, the call tree are not visible. I'm certain this issue
> > >>>> is related to the format of the JSON file or if there is another underlying
> > >>>> cause. I will continue investigating to determine the cause of this problem.
> > >>>
> > >>> Great Anup, progress can be frustrating slow at first but it is a good
> > >>> milestone to be generating output and having firefox profiler consume
> > >>> it. You can open up the JavaScript console for the firefox profiler
> > >>> and it will give some debug output. This should hopefully help you
> > >>> make progress.
> > >>
> > >> This week I tried playing with perf-script-python, the first challenge was
> > >> figuring out how to parse the data coming from the process_events.
> > >> Understanding the structure and extracting the necessary information
> > >> proved to be more complex than anticipated. This required me to spend
> > >> a significant amount of time researching and experimenting with different
> > >> parsing techniques.
> > > 
> > > I'm not sure what kind of parsing you meant.  IIRC the sample data is
> > > in a dict and all the information should be available there.  Maybe we
> > > missed some new sample data types though.
> > 
> > Most data is there.  There are existing scripts in
> > tools/perf/scripts/python/ for reference.
> > 
> > There is also the dlfilter API:
> > 
> > https://perf.wiki.kernel.org/index.php/Latest_Manual_Page_of_perf-dlfilter.1
> >
> Hello everyone,
> 
> I hope you're all doing well. I have been working on the using process_events function and have made
> progress in developing the converter script. Currently, I am in the testing phase. However, I
> have encountered a problem after performing some recent compilations. I am no longer receiving
> the complete callchains in the output as I used to.
> For Example, when I ran the command perf script -F +pid, the output would include detailed
> information like the following example:
> 
> perf-exec  132554/132554  171854.674582:        356 cycles:P: 
> 	ffffffff8fab3fc6 arch_static_branch+0x6 (inlined)
> 	ffffffff8fab3fc6 static_key_false+0x6 (inlined)
> 	ffffffff8fab3fc6 native_write_msr+0x6 (/lib/modules/6.4.0-rc1/build/vmlinux)
> 	ffffffff8fa12ca5 intel_pmu_enable_all+0x15 (/lib/modules/6.4.0-rc1/build/vmlinux)
> 
> However, in my current situation, the output is limited to the following:
> 
> perf  108107/108107  [000] 67650.031827:          1 cycles:P:  
> ffffffff83ab3fc4 native_write_msr+0x4 (/lib/modules/6.4.0-rc1/build/vmlinux)
> perf  108107/108107  [000] 67650.031832:          1 cycles:P:
> ffffffff83ab3fc4 native_write_msr+0x4 (/lib/modules/6.4.0-rc1/build/vmlinux)
> 
> It seems to be issue in perf record. I would appreciate any suggestions or assistance
> in resolving this issue. Thank you all for your help.

My apologies, I realized that I had mistakenly not included the '-g' option,
and it is now working fine."

> Regards,
> Anup
> > > 
> > >>
> > >> The second challenge revolved around the usage of event hooks provided with the perf script
> > >> python event handlers. I found myself deliberating between two approaches. The first
> > >> approach involved creating custom functions that would be called using the event
> > >> handlers. These functions would then save the data in an organized format within
> > >> globally created data structures. The alternative approach was to write the entire
> > >> logic inside the event handlers themselves.
> > >>
> > >> Additionally, I contemplated whether it would be more suitable to handle the creation of
> > >> a Gecko format for JSON and the profile format within the same script or to separate
> > >> them into different scripts.
> > >>
> > >> I will discuss this points during tomorrow's office hour.
> > >>
> > >> However, I have gained a deeper understanding of the problem at hand and will use this
> > >> knowledge to make more informed decisions and progress more effectively in the coming weeks.
> > > 
> > > Sounds like you did a good amount of research on how perf script
> > > works.  We can talk about the details in the meeting.
> > > 
> > > Thanks,
> > > Namhyung
> > 
