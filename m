Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6554738F03
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjFUSmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFUSmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:42:37 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BC91A4;
        Wed, 21 Jun 2023 11:42:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 8A3613200929;
        Wed, 21 Jun 2023 14:42:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 21 Jun 2023 14:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687372952; x=1687459352; bh=x/
        qYbwCgeTODxK3PDO1cDsIUXATfTIrzjbo84n1In5g=; b=k3bxJ4Bk+KdKGDC6iP
        NAMvzQN4/RjQw/6gXQhMqzp3gaCrd+g5mkQeJ0gDVZZTifuV0Hdf52eRgZC4qXuE
        hrYOGRC8P643mobNjDowCTIkml2swgMRd0NrThRxyYR5/GtSJwe497vrGbSTr05y
        hs6wqsACFyJunGhPtW9Af0TfzXQu+owv65gXQGkNqG9WK4jEuvd5wsq2OPlJnFTb
        LJ4KkEZA6xMJIE0Qgxtfq+BsTF+0ZqdAff6kBwJ8RZsv+w+wFHMG/QGvMjb2Cs21
        OFQ8CSqR+vZzvNHOoWPROoxrWnLo0oSab2S45UMQjM/3STigTVpGEXYDovBLq6pR
        s/Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687372952; x=1687459352; bh=x/qYbwCgeTODx
        K3PDO1cDsIUXATfTIrzjbo84n1In5g=; b=oGU8w+WKcCwQz6HGxT7sMFhklHoJj
        IP6vYl1XK8kgKRzVyD9RlpGvgtw0tH844DbE6G4B4Wi9NvbrBDEV+a6JxPYveQLr
        S3iiWW2Mxku5kpz5tPKOHtrFXYrSt3LGQrOYB8u3E6fNo4Ow0e6AFcxXmTm/TGcj
        bejiTaVT3/UbyK2RAD2hwRMDeZbwqTuwfTrAauWumm59vI3Mw/5+9j1N0bR18WKc
        oYXSS6M701zIAM94UK6TJj2ybF9LkljwOxI3KyoHmEvWq3sp/iMUwNOxgkVd/yb/
        O3up9hgspAT0D5/p6OmVKe/pAqrnETWAMLyr9Cgp8PkIoJ1l0CcUUJmfA==
X-ME-Sender: <xms:l0STZH-uHDgr2OXrQpezn7aiFPgaL0V7C0L7hgcbQB9tgBcO5spsiA>
    <xme:l0STZDuCBvDbekgT0gGsFfEheXb9QGtOeXsXHMkTM2eptd9XTLkttGjpOqxT46oBl
    Qev7N6ontvU3sSu7IY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefledgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:l0STZFDNijvV1q6MRBl5StnQxKfZBMgp0rh7qJKuVBOtKWOwajdg_g>
    <xmx:l0STZDe3Mvl59w73s9CdqzxOZS2AnNMJbxSCW4ivAFRnTZB-fELxPQ>
    <xmx:l0STZMMwK4BmzT_Zzo4DDaWL-EuHAnKvMoUWojvqpA7-_WzPVhk93w>
    <xmx:mESTZDcR0RNFwRlwcx5tShZxVsq4xMT42cTUeMOQkkL7SkWsEhXslw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 95EF5B60086; Wed, 21 Jun 2023 14:42:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <336f2156-220f-47ff-be97-5a2a9c475372@app.fastmail.com>
In-Reply-To: <202306211131.18885FF471@keescook>
References: <20230616092233.3229414-1-arnd@kernel.org>
 <20230616092233.3229414-2-arnd@kernel.org> <202306211131.18885FF471@keescook>
Date:   Wed, 21 Jun 2023 20:42:10 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kees Cook" <keescook@chromium.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Anil Gurumurthy" <anil.gurumurthy@qlogic.com>,
        "Sudarsana Kalluru" <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Azeem Shaikh" <azeemshaikh38@gmail.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] scsi: bfa: fix function pointer type mismatch for state
 machines
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023, at 20:33, Kees Cook wrote:
> On Fri, Jun 16, 2023 at 11:22:10AM +0200, Arnd Bergmann wrote:
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for all this! It's a lot of mechanical changes, but looks correct
> to me. One nit below...
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
>> [...]
>>  static void
>> -bfad_sm_uninit(struct bfad_s *bfad, enum bfad_sm_event event);
>> +bfad_sm_uninit(struct bfad_s *bfad, enum bfad_sm_event);
>>  static void
>> -bfad_sm_created(struct bfad_s *bfad, enum bfad_sm_event event);
>> +bfad_sm_created(struct bfad_s *bfad, enum bfad_sm_event);
>>  static void
>> -bfad_sm_initializing(struct bfad_s *bfad, enum bfad_sm_event event);
>> +bfad_sm_initializing(struct bfad_s *bfad, enum bfad_sm_event);
>>  static void
>> -bfad_sm_operational(struct bfad_s *bfad, enum bfad_sm_event event);
>> +bfad_sm_operational(struct bfad_s *bfad, enum bfad_sm_event);
>>  static void
>> -bfad_sm_stopping(struct bfad_s *bfad, enum bfad_sm_event event);
>> +bfad_sm_stopping(struct bfad_s *bfad, enum bfad_sm_event);
>>  static void
>> -bfad_sm_failed(struct bfad_s *bfad, enum bfad_sm_event event);
>> +bfad_sm_failed(struct bfad_s *bfad, enum bfad_sm_event);
>>  static void
>> -bfad_sm_fcs_exit(struct bfad_s *bfad, enum bfad_sm_event event);
>> +bfad_sm_fcs_exit(struct bfad_s *bfad, enum bfad_sm_event);
>
> This bit doesn't seem needed? i.e. why remove the prototype's argument
> names?

Right, my mistake. I went through a few revisions and first tried to
change the prototypes here, but later changed them back. I missed
this after I folded my intermediate steps back into a single patch.

    Arnd
