Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256765E6A77
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiIVSNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiIVSNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:13:52 -0400
Received: from ach1ajh115.fra1.oracleemaildelivery.com (ach1ajh115.fra1.oracleemaildelivery.com [138.1.108.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6B3F6861
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-fra1-20220101;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=hMbKnsDfGuZbST3+iKB8T0JJtGf8/ETxt5BDAqjyo60=;
 b=FXYyBWbm2KZCo8oOR6GuTWocRwSDPxtgpRP3wQRSqj6UH+CXUwKn0LPuF2CjH6USA/+MeqV2Zizx
   U9+pMzLzqaBxzwRzc5PmPqH4b5JhbGqXUcy84I1TWA1vWhcxn8b0pe+VznEEvUnUbr905lfohyQU
   TGxfHCndMPqz/H3Gqd8jApa+GyiKXfPUkJGmMs5j8/VxPpv1BhZl+4y1T32SO3zZq+4gvAT3K04n
   whg9no5siCSdLWdNbGvppr8zaT79aUwy4m2fSSkdUo7+qJNI5hTN2FhWB14/Qo/ZrKGM3uH/Szt7
   F6egfWPLW9vM1jUqSU5YsH8zxqZy2iDcCYmWxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-fra-20191115;
 d=fra1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=hMbKnsDfGuZbST3+iKB8T0JJtGf8/ETxt5BDAqjyo60=;
 b=BijYoPiyAwNXbWmqegRJ5wx3OmVxM/8mrX1eSiLCvhaApKTQ48zk2zMv2xGmKxOdcWYwjDqzceE6
   Iyf9H8ZbRBUDNy45K/bWsEW3wNARcd4A+mmDDGfxlnu3ETqOQ6cYNgpIZqqA979ivBnRNuXdqpra
   eS5hCt4iVi3xmbd0Nrmy0lCc+6aTjmAq+B0W7R6qZ2vOcoZXi71BQ2q2qssF58Jt7FPkhdzTKnRV
   X22K4t17tzudeZ3zo928Kb3vr5MsLsgiGh6QqAWMWq72jLPDxEvAtNTenqsTEFxdlaNuDri6zNOC
   WmOtSybNYUJ5v0XgtmaAcOOiBIjzP7s1Uy1BIA==
Received: by omta-ad2-fd3-202-eu-frankfurt-1.omtaad2.vcndpfra.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20220826 64bit (built Aug 26
 2022))
 with ESMTPS id <0RIM00IGSIMZ6R80@omta-ad2-fd3-202-eu-frankfurt-1.omtaad2.vcndpfra.oraclevcn.com>
 for linux-kernel@vger.kernel.org; Thu, 22 Sep 2022 18:13:47 +0000 (GMT)
Message-id: <33cf5071-3157-a3c2-3252-3a8ab926c60d@augustwikerfors.se>
Date:   Thu, 22 Sep 2022 20:13:39 +0200
MIME-version: 1.0
From:   August Wikerfors <git@augustwikerfors.se>
Subject: Re: [REGRESSION] Graphical issues on Lenovo Yoga 7 14ARB7 laptop since
 v6.0-rc1 (bisected)
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        regressions@lists.linux.dev
References: <c1f8886a-5624-8f49-31b1-e42b6d20dcf5@augustwikerfors.se>
 <eee82fb8-0fc5-98cb-e630-f86891574f21@leemhuis.info>
 <CADnq5_PRP3ekHPLhdXALxt9GL3aHHZQUw5TNAwm4t+ggimUq7g@mail.gmail.com>
Content-language: en-US
In-reply-to: <CADnq5_PRP3ekHPLhdXALxt9GL3aHHZQUw5TNAwm4t+ggimUq7g@mail.gmail.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAHbDiOyw7PQ+YvQ6Tk2wL3boCy4Gse2rKd/OctvMwiREQdSmCjJhUzxDqPn50D4
 b2YL7+qFbADcEhF5v3aqKRWdW4C9GDLg1v0zCEesheVk5teTuP6L8+iQb/0tJ+8U
 hSKxQbyGrmunmbaqIpqk888yeTIIG1XuqLgGOgo1hLQ4JKpxXdv648D8QhO6JrXj
 qGi3zL33B0po4WwwwET92YCnHHv7IY9sg9LhVsKWXOrv5JabLgvcwABGXkiHmn0D
 qY51KM40XdVwdpCLYQ34SNxVaY3AqDVbW/4Cb4dd9NX7qyzSXjV7/fZ7whyGdCJ6
 YS6K7g/7sSeguYNl5E5Vs0cMDDPigKSnzscBzb/bDyfhFnmGl0oskLJCVmZ9uPym
 JMjHTpp99aEWw5fIT2v4E56iaQu/WEsxY68RPfyGoCdWM6vHTbbhrfpVdfckjwaN ERYMvB4=
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 2022-09-22 15:59, Alex Deucher wrote:
> On Thu, Sep 22, 2022 at 8:54 AM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> Hi, this is your Linux kernel regression tracker. Top-posting for once,
>> to make this easily accessible to everyone.
>>
>> @amdgpu developers, what up here? August afaics didn't even get a single
>> reply for his report that even identifies the change that's causing the
>> problem. We're already late in the development cycle, so it would be
>> good if someone could take a closer look into this before it's too late
>> for 6.0.
> 
> Been a busy week.  Haven't had a chance to look into this yet.  Does
> the issue still happen with this patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=66f99628eb24409cb8feb5061f78283c8b65f820
Yes, the issue still happens with that patch, and also with the current 
git master (dc164f4fb00a0abebdfff132f8bc7291a28f5401).

Regards,
August Wikerfors
