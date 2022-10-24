Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECB260B737
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiJXTVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiJXTUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:20:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D9C6FC42;
        Mon, 24 Oct 2022 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=d0M8i6++Jn/HyOh+q8qf62zWar6VhxSYia86EHd5PGU=; b=MlcbCDNfDSRC0lNdZGJsr1Ijaz
        tb8VQCaym0f+3DW39UIXqPqaJqpVbV3ZLy675FcGNxe96Y6kKGlhIx0Pquo4e+meBtzVs4tjxe4tO
        d+qlqWzGst2paP0Bdsqt0n5VqjrLbEUDVwCt51FI+Q516IlXpAYwDLg9+qAEfVP+JKr1v+3tNRq40
        Shw/PpZsRu1YVT5QaNevSrKt51SdSdgn+QxfrKEwPNBg3IKadfEVtwIyZN32kAdv0qrgHuHtFAbP9
        UpSQIEYGg6U0TVCJ66ww0xEXYXKliaSFuFsknTRRJ+gxAi8E50pFfcdiG+Awp/LWm50BmBEphGMXD
        dZ6TCXXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omyx4-00FWf0-RB; Mon, 24 Oct 2022 15:01:18 +0000
Date:   Mon, 24 Oct 2022 16:01:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     Akira Yokosawa <akiyks@gmail.com>, bilbao@vt.edu, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 1/2] Documentation: Start translations to Spanish
Message-ID: <Y1aovvn7dAyo1nuW@casper.infradead.org>
References: <20221014142454.871196-2-carlos.bilbao@amd.com>
 <48b4a5a1-2a52-4159-699b-9db73a012892@gmail.com>
 <Y01pkubcT7FOwCjL@casper.infradead.org>
 <8e2a1da1-2914-b223-85b0-a769339d9c39@gmail.com>
 <9e65ba16-68d3-8d11-c6ac-c35c29026688@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e65ba16-68d3-8d11-c6ac-c35c29026688@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 08:40:42AM -0500, Carlos Bilbao wrote:
> > > I don't know what standard we're actually following.  RFC5646 suggests
> > > simply using "es", with "es-419" for Latin America specialisation or
> > > "es-ES" for Spain.  I don't know how much variation there is between
> > > different Spanish dialects for technical documents; as I understand it,
> > > it's worth supporting two dialects of Chinese, but we merrily mix &
> > > match en_US and en_GB spellings.  Similarly, I wouldn't suggest that we
> > > have separate translations for fr_CA, fr_CH, fr_FR, just a single 'fr'
> > > would be fine.
> > > 
> > > We do need to be careful here; people are rightfully sensitive about
> > > being incorrectly grouped together.  If possible we should find a
> > > standard to follow that's been defined by experts in these matters.
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FIETF_language_tag&amp;data=05%7C01%7Ccarlos.bilbao%40amd.com%7C44c226d534f44b4afc1f08dab0b1893b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638016573808784843%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3T9bPQzcj9hEuZiPkjIU%2BPCEaxAivgaNKZ2gL5m3OQA%3D&amp;reserved=0 may be a good place to
> > > start looking.
> > I think generic "es" is OK, especially if "es_ES" can have such a
> > negative connotation to some. I just wanted to point out "sp_SP"
> > looks wrong.
> > 
> > Carlos, if you go the "es" way, it would be better to mention the
> > reason of the choice in the Changelog for future reference.
> > 
> > Subdirectories "ja_JP", "ko_KR", and "zh_CN" were added under
> > Documentation/ way back in 2007 (v2.6.23).
> > 
> > As you might see, two of the three language codes needed region
> > distinction and they were reasonable choices at the time.
> > 
> >          Thanks, Akira
> 
> Answering to Akira and Matthew below. Thanks to both for valuable feedback.
> 
> I made the conscious choice of not using es_ES, because as mentioned, it
> references a standard that I don’t intend to follow myself or enforce on
> Spanish translations. es_ES is a standard that comes from “Esp”-aña (Spain,
> the country) whereas “sp_SP” is as in "Sp"-anish, the language, not the
> country. Regarding this, I took the liberty of adding an extra paragraph to
> index.rs. I would translate it to English like:
> 
> "Many countries speak Spanish, each one with its own culture, expressions,
> and sometimes significant grammatical differences. The translators are free
> to use the version of Spanish which they are most comfortable with. In
> principle, these small differences should not pose a great barrier for
> speakers of different versions of Spanish, albeit in case of doubt, you can
> ask the maintainers."
> 
> I also opted for not using es_ES due to its geographical connotations. If
> someone from Peru, Mexico, Argentina, … submits a translation tomorrow, I
> would review it and we would understand each other just fine. Even within
> “Spain” there are many dialects and things change within regions. I
> reiterate that all dialects should be allowed in this directory.
> 
> Fortunately for us, versions of Spanish differ much more in spoken form
> than they do when written. This does not happen between traditional and
> simplified Chinese.
> 
> On top of everything else, using locale es_ES may imply that spell checks
> on that directory using the locale es_ES would be clean, but this is very
> far from reality, among other things, because all the English terms we
> inherit regarding computers. As Miguel Ojeda pointed out somewhere in this
> thread, there are terms that is better if we do not translate, to favor
> understanding of code/other documents.
> 
> I will update the corresponding commit message to clarify why we are using
> es_ES format in this particular case.

I think we're better off following BCP 47:
https://www.rfc-editor.org/info/bcp47 rather than the libc locale format.
That will imply renaming it_IT to simply "it", ja_JP to "ja" and
ko_KR to "ko".  The two Chinese translations we have might be called
"zh-Hant" and "zh-Hans", if the distinction is purely Traditional vs
Simplified script.  If they really are region based, then they'd be
zh-CN and zh-TW.

I think you're right to conflate all dialects of Spanish together, just
as we do all dialects of English.

Jon, this feels like policy you should be setting.  Are you on board
with this, or do you want to retain the mandatory geography tag that
we've been using up to now?
