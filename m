Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C7C5F748E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJGHHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJGHHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:07:38 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847F6AD9BF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665126456; bh=UeMreazR8SYf+lFRIeitfancL+8D6F/spR9g2FRqRsY=;
        h=X-UI-Sender-Class:Subject:From:To:Date;
        b=XSwhD/6mrrchOhNv+RAGbZ/hrTlMOtzpBDPjnfU3Ubdo9IHRv/MjLSHuxpKemLG4i
         LDyTiXs6R30Uc4lKlmOPtFBRMlnEJwKSoBeYaa6fKE5vVQannz3NahaDks/9h2cxH9
         uyJt/2MVydCl83+1YGFtjMzBA5/6SWztn8k95YiNAgjfHVXTlohWar2jHo+Fp4C3Bb
         DPvHRMb7A6tWh/mD/EBmlbTmCZzsOt/L+/OAxSVLhQ49G1CJlKAy8AsDChsRCDx9IJ
         3XMc9oLWZp4rJOq4MKT0tXt3N26360lg+jw3fXDhZaIWsgQ4yInA9sDtpDSIFCZnRq
         sgDI5vztSlVEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFaui-1oPgPR3bqg-00HUDl for
 <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 09:07:35 +0200
Message-ID: <e2cb929d827f202df3ab315090b69b3d3e33d909.camel@web.de>
Subject: Re: [git pull] drm for 6.1-rc1
From:   Bert Karwatzki <spasswolf@web.de>
To:     linux-kernel@vger.kernel.org
Date:   Fri, 07 Oct 2022 09:07:35 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0-2 
MIME-Version: 1.0
X-Provags-ID: V03:K1:mmZpeBLTijtjc61VvKC59BtqxYlFwhO5Zr1f6Pwanea6Xbkj50v
 VwmfM1qq/XW3jJvxvvUQmCmNjA4AC7MBHAez/nkczPspPflh1/viBNZzGDLDh1w4FE5souF
 CZVeXdmq7kzGG9mP9/uh3hMMlWvsi7sKpNgfazvxY/GZhAU4b+vGm5kdXRBIJZ5yJD+ajML
 pUACn1WH4uGNBWv9oH8+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IzeDZWdB3tA=:Bu/v+EQxL6pT3vX+z1WaCE
 GS90YMYwLlSOvXHSTHxCmELN2T+IzWdo2S1HGI87dqe8eAvRKwYz//ZcTkOlNF8FI0coy9ple
 /v4vFHfsNcVe6/Rq7YypOZ++TWNnC6CnwIUjf1BP2LMOKsCRUJ0GbLM9vJQizGhTqs2jtPuc6
 yFyRuobgdEIduXVXesDqPx0wIwGT9a+hqG9Z7Nz19tb3uJgaLVlEaXyvc9Y8766Lg0kRZjc5m
 RoEOND6omPaoG6ZGA7XHZmaVynX/VfmMMzaX7YxCm/hl/JtamhMgSJHkK72sfltCZ+TZjZN3O
 kfPGDhgI6dKeeHtCvq2666ZtbC6wWrNpFAmt0eZ4Nasw1Wr6gn/hriC4yoalc/EEJPzlvVKRf
 I+07L5fiIZ+y/GPrFEz5s8IesHwKh0kDs1DkXls5KQ/HhzkNKbp9ZDvf058ZTItoCAakV1cXm
 2wl/193p4aGnV8ALmkJnXDo8II5J7d8YfcsukHueiWZl39o7Dzy8S9nFF3IAkwb9F/Lclkw4d
 UKWWpFznNwJJQI7xaNiyjyqtVsY7XZ+UbaGaEfuibgT7TnbhWnh3GP/0G3fASE+kwM2Tukl7P
 tmP7Z7MB3tkwGvd2rHL25hCeMuXH/EzPsrK4IGbSeqcOxiixItJNPeB6DDebML6uKi8q/VL/v
 PzkLGKGe9xZqYyKHIA9kYeHl0AOzDHwG48VogoD4B7rNTY2xQEcpP7AZejLq5mKKgBCYMOIkT
 6R0C9yGV1wlUhi+Yjzt37ELbdyr76YYO2lrLbDBr1E7kgcz9b7MeidXY7iW+lt3HaddxHqGkm
 wssfZX59gxzyuAFcSWL1dX3ydbINUkWiflQqNu7gvGr9zMucvsPMRpCu3uDrQLHVk4RwQcIR8
 i88jCuzoOzWHordatcXlogpQOEc+Z4nD3ewTAviRdRcPUhSJgX5E9v/IJKm76l7H/RO3eEGPe
 a6XbuXOlZ44dXvu4JNVB/2WEhmNAjbTwzMWYyjY71qPbiG9BXMcXkV8qi25G8JpCytnam2TET
 sPDIEetvHIdZldipKlH3ERPyYANupPTOXLWmWBUPh6b0tfGpqvKANk48PAxnV4lMpn1ugXQv/
 D/u2CWI4WxESy+D5HBHR9e7Kyra2HVK+H4/6igeGyKio4xLeKp1OZ0jDyxu3ZWhuxB4Ab+7he
 TkXoNiCKS9dNL/+fkjAOmAGGjH/ntXR8FsPyIUpNe4feA3c/aY8wPsig4yRJUyv/Q+yz+T+Ij
 0d2Ze+VaAMoAYUouxU6tXUvIh+VQJQ2JusHl/xJdikgcjlqNq4OxJK2CfV5i+M7ui8XUShceU
 tPZ6jDY0aCOMDJJeCGfoknxchdP7RsSXr3c6dQKLg57lMeQclMBJ6x+fIe1TWpp84VhSVsSt1
 XEidLC+T/MxBwVRLBAG7L710X8XW4f+Nc1ryWdgJWDHv2d6KWBn9Q205FnoHURUGmgUzjVo0J
 AbapFykpLqlHAvTwLMSHMIEfp7NS7xJXmdb23Y3/FoKEYcZneOjzXO2ahsdLtOOxxIT5paC/w
 VulW3MrnlwhAUulG73Kx+gQgU3nunor/BzNVp5SLHF0O1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 3:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Oct 6, 2022 at 12:28 PM Alex Deucher <alexdeucher@gmail.com>
wrote:
> >
> > Maybe you are seeing this which is an issue with GPU TLB flushes
which
> > is kind of sporadic:
> > https://gitlab.freedesktop.org/drm/amd/-/issues/2113
>
> Well, that seems to be 5.19, and while timing changes (or whatever
> other software updates) could have made it start trigger, this
machine
> has been pretty solid otgerwise.
>
> > Are you seeing any GPU page faults in your kernel log?
>
> Nothing even remotely like that "no-retry page fault" in that issue
> report. Of course, if it happens just before the whole thing locks
> up...

There's also this issue with the drm scheduler which causes a lockup
without messages (but with a flashing capslock LED). Going back to
checking the finished fence solves this for me on this device:
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi
23 [Radeon RX 6600/6600 XT/6600M] (rev c3)
https://gitlab.freedesktop.org/drm/amd/-/issues/2179


