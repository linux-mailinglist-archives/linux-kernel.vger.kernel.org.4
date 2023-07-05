Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B7D7480CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjGEJ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGEJ2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:28:18 -0400
X-Greylist: delayed 3349 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Jul 2023 02:28:13 PDT
Received: from esgaroth.petrovitsch.at (unknown [IPv6:2a01:4f8:120:527b:6876:2a4f:a044:62ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B6B1725;
        Wed,  5 Jul 2023 02:28:12 -0700 (PDT)
Received: from [172.16.0.14] (84-115-216-135.cable.dynamic.surfer.at [84.115.216.135])
        (authenticated bits=0)
        by esgaroth.petrovitsch.at (8.17.1/8.17.1) with ESMTPSA id 3658Ve1G3043130
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Wed, 5 Jul 2023 10:31:42 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 esgaroth.petrovitsch.at 3658Ve1G3043130
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=petrovitsch.priv.at;
        s=default; t=1688545904;
        bh=hF/IfiEBnsCLKhouXrFQ8MKHzlbIFna5M39DjQ6ZLlA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jzUminHNuFWP5fjiaOwsgLdcy5whhnNgh1Ri8niAmL5GqGWM8+2QkUUp83mhSbH5z
         3MLcFu7YMlEBOnVneMMu5QWzkTxt9C25lZ55XdN7OCXhBPARTEK9mh3fGJRmH1EkU9
         2Q/oaYTOrYTZ19oDW12SAazfnbd5G0+mlYz53i0A=
X-Info-sendmail: I was here
Message-ID: <98724f26-8a88-8775-d92b-2b7941e96cd8@petrovitsch.priv.at>
Date:   Wed, 5 Jul 2023 10:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Overly aggressive .gitignore file?
Content-Language: en-US, de-AT, en-IE
To:     Willy Tarreau <w@1wt.eu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
 <20230704211509.GA21834@1wt.eu>
 <CAHk-=wjH4O6v_EwVB=t_6Haky2jOiejHbCkCTvgNQWo1ghy8-w@mail.gmail.com>
 <20230704213415.GA21872@1wt.eu>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
BIMI-Selector: v=BIMI1; s=default
In-Reply-To: <20230704213415.GA21872@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC-sonic-Metrics: esgaroth.petrovitsch.priv.at 1254; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2023 23:34, Willy Tarreau wrote:
[...]
> I did and for me on this machine I don't have the problem:
>>    willy@pcw:~/linux$ git status
>    On branch 20230702-nolibc-series1+2_2
>    Your branch is up to date with 'origin/20230702-nolibc-series1+2_2'.
>    
>    nothing to commit, working tree clean
>    willy@pcw:~/linux$ echo blah > 2023-new-patch.mbx

Create 10k files instead of only one and you will have the above described
problem (filename completion takes ages because of untracked files not
shown by `git status`).

Kind regards,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
      There is NO CLOUD, just other people's computers. - FSFE
                      LUGA : http://www.luga.at

