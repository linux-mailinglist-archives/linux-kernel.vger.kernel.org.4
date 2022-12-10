Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984366490CC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 22:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLJVDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 16:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJVDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 16:03:49 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D310515727;
        Sat, 10 Dec 2022 13:03:41 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.187]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M42X0-1p46zk1RVQ-0004TJ; Sat, 10 Dec 2022 22:02:52 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 94DCD3C1B0; Sat, 10 Dec 2022 22:02:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1670706168; bh=7qSFBPGHl0bfqIeEqeYNfCRTFMgAscCGdAYDrFciekQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UG8rqOQbvcecqzqAJfHX7/67UxATB7jBBpiKkInUIQkDxDQLn3DlhFpQIL5oBRuqI
         KPQ0eqcFzmVIpiMApE6gsfoO4oeD9TlccyIWb1MGXahNIutKuG2T1IHMHfKcHE1NjD
         Hh0XRkKYCmZ9UGbvfpIDR/HkXhHEBnpVzsvFjVhY=
Date:   Sat, 10 Dec 2022 22:02:48 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 3/5] kbuild: add read-file macro
Message-ID: <Y5Tz+MBfYMVkqAn3@fjasle.eu>
References: <20221126225624.751661-1-masahiroy@kernel.org>
 <20221126225624.751661-3-masahiroy@kernel.org>
 <20221207154044.2181347-1-alexandr.lobakin@intel.com>
 <20221207162208.2200189-1-alexandr.lobakin@intel.com>
 <CAK7LNAQbGaXDRzeByOcJhMX4y-ShA6Qtpcqhr4gNZ5t8vX-PPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQbGaXDRzeByOcJhMX4y-ShA6Qtpcqhr4gNZ5t8vX-PPw@mail.gmail.com>
X-Provags-ID: V03:K1:MQr0B95Rb2frj5hoYtDcHcvz46tIGN3vAvFxXptwL5n4uUmWEBc
 S55km1w89a8cYBpeAt0E2tymvkY2s1DxGCBw7dJGisDA+jyfy65ZINIEBZrlUXYDcYhfNhg
 GuSbgMxzIxNkF9Incnc64Ocl4tIEZSh8ctfqCr3bKFCZN+EbnLFiW/53WitDbQ+YRLrqXUZ
 dVCrbSRLvlvM1khT2rXFQ==
UI-OutboundReport: notjunk:1;M01:P0:AhPU3HFi/yg=;BQgylnf9syDxKYtQpyLisUDJliE
 Vg9P3oFbpoaClJSTdY7aCKIoHWJPNRQwl0jSjwqbPRnGM4gyxrxwfM8O+tJLRGQTlNv293Ynx
 4r/Smwn0AQ3RcCW9Sgjx0S3MOAwIv00+x1XBDDnvNPe3ElqIcE/xAEsjHckaf2W8XGNJ3HHUL
 7dzsHMGEadqDR8lOgyHtp7rCQ8u2rrUEMir1egY1BiSYbzV0liuFSyrEJpfHdzdOLl9GmjfHk
 qw9TOH8jIFZxYP8qdbOxCPLz1HnNBEvXsHi87pctdTKPBmvVe39RtRj37ogqD5sI49/sbSs4s
 4MIhctyGL921dxFkyR4To24N9F+0u8qbx1I78rDrQcA3Ne3Mj2af3HoLqkjLCHNyjd161WSWT
 uAFuY4Ma4aDtJgfSwv9MonNHZ4KkZqfQjIXNy6x8PHOl8t8ba1xQSwaCI2RHbbqhIH6+4yNYm
 vt2tcbZovCbfgp4RXp4EF/6j4hhSDCWVIGlJ+maVGWvzFDwz4vpFMiob2VzNXLI5mcnjJQ0rL
 422JdlZl8FNKYkfRmhSxz0+Jv2og+VqDwFA7R79/NwlhYegEhufxVs2+nJogUnEUrXwfIQKZT
 BZwOLI9iLgIOrmM6qNtFxdPiSy9b+bRsMNM+BdSUdhLpU481ny5Jh3JfHy6uRRP7c+D3J0MOI
 uWiU0f0GePIokuJPZ1gTi9zi3Zh5QrUdN0+AZXRorg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 11:10:12PM +0900 Masahiro Yamada wrote:
> On Thu, Dec 8, 2022 at 1:25 AM Alexander Lobakin
> <alexandr.lobakin@intel.com> wrote:
> >
> > From: Alexander Lobakin <alexandr.lobakin@intel.com>
> > Date: Wed, 7 Dec 2022 16:40:44 +0100
> >
> > > From: Masahiro Yamada <masahiroy@kernel.org>
> > > Date: Sun, 27 Nov 2022 07:56:22 +0900
> > >
> > > > Since GNU Make 4.2, $(file ...) supports the read operater '<', which
> > > > is useful to read a file without forking any process. No warning is
> > > > shown even if the input file is missing.
> >
> > [...]
> >
> > > Great stuff. Used it in my upcoming series to simplify things, works
> > > as expected.
> > >
> > > sed-syms = $(subst $(space),\|,$(foreach file,$(sym-files-y),$(call read-file,$(file))))
> > >
> > > The only thing that came to my mind while I was implementing the
> > > oneliner above: maybe add ability to read multiple files? For now,
> > > I used a foreach, could it be somehow incorporated into read-file
> > > already?
> >
> > Oh, nevermind. This one also works:
> >
> > sed-syms = $(subst $(space),\|,$(call read-file,$(sym-files-y)))
> >
> > So I believe read-file works for an arbitrary number of files.
> 
> 
> 
> Really?
> 
> 
> In my understanding, $(call read-file, foo bar) reads a single file "foo bar".
> (a space in the file name).

yes, except for make < 4.2, due to:

read-file = $(shell cat $1 2>/dev/null)

