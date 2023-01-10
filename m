Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709166636AD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjAJB2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjAJB2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:28:05 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF70A395E3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 17:28:04 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 14E6F320025E;
        Mon,  9 Jan 2023 20:28:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 09 Jan 2023 20:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1673314081; x=
        1673400481; bh=zeB8Rjm8Q9ysFSyGBjwVWVghqqA5Z8exrt+ZdLm1v4Y=; b=A
        F+CTNwF1+397YVLctQ8UFjga/E+HypkOFOFohjDGazzBZo6IktXplX+dStCLuwkJ
        1Kd37/WpFE7Fg1BgstK13saN1ryE8pZUNF89A3xRzrBubuRY5u3DvOx7F4FBKxMZ
        zXXJgF8NeHkjw7JrwlYy2lbUeKPGE0SvxzkqNhdu7DeyMGnrYb+91NMZbsbZFZ9M
        XWp0WTuILTBaVvNpY4ZUG3zkA2tBSKI+J/g79Ye8YPYNYWGzY1D5bU8pqnsanbIz
        BagjdMbkWdcC7qkc9a7FCAyFLW1DvBh/wyPtFkMnhitPrCp7g+UrGok9Tu9pSlBD
        TGo2is2u4Sv7Meuoo94IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1673314081; x=
        1673400481; bh=zeB8Rjm8Q9ysFSyGBjwVWVghqqA5Z8exrt+ZdLm1v4Y=; b=m
        SL813OJ+ORX8ZjF+wmA02IBhtdPBLxgwU9KPPRU8IeddBFY74dk5CUxss7t/lQ6F
        DS+SA5SpPxrZavPEMLALfnXyV5rNetdw/yEXLrp0tAw6HrTYbQSrQg74JIKKlYLE
        fhcAQr8SIgEWMI9ee75Qlk9Vm0q6Hv42IOnPHKI8uxuAYiGCuRe+S6/NzBy22O3O
        AZjOJ58y3NKKEbDOjMYj0odYr++SzkicksQzlJ/Fs0jwFvP/ad+2Y5jvhSKXLkl2
        6H7XK7nvH9PVBdpWA6rP6AbOj1kjBAIsHJYEjq+B4QlAq2WIVbFqHEClK3JtrCng
        D+WEJtw9uGxh7l3dcQ3eQ==
X-ME-Sender: <xms:Ib-8Y1HWi2MqOspulEpkfTEKwXpqswdoD_qHkL8WkhKOiwcldfWCjw>
    <xme:Ib-8Y6UiuR1OTrTZXV7jJThZ7Hb3gLojaIOX0ZlWvHxgS9c3hkC5PFLia6XJ4WPNV
    stwkfwtBkydCoTnGA>
X-ME-Received: <xmr:Ib-8Y3JWcPp3fEEf7kvoN8IIzqCuSAE07za3_HoXMw5fq9-WmlvBPMYeKaFS8kA0OE0jK3ptLYyMyqfko2xoQCiHhgs8aRYkzpHTS-V4fUM_bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkeejgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdeftddmnecujfgurhepkffuhf
    fvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhr
    rhgvhicuoehruhhstghurhesrhhushhsvghllhdrtggtqeenucggtffrrghtthgvrhhnpe
    etgfeilefhueefvedvkeehieefjefgfeegheetudekiefguddutdeukeetveelleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurh
    esrhhushhsvghllhdrtggt
X-ME-Proxy: <xmx:Ib-8Y7GmemFyzfbC4lEY0hQ7juWFKMY8bkgzIHK0VJhzfmJuna3SOQ>
    <xmx:Ib-8Y7XDaxiIQi1cjWl7_Zj-C_6zp0OGwvxHtNu_i9czjQZr3U0w0g>
    <xmx:Ib-8Y2OOeRl2vRI7R3EBKDWKWa86JhUsEoDJDx5N0-uWd_3384K_3Q>
    <xmx:Ib-8Y9JxT4YKDsrBOkZ3Q6vUDyJh6G_Az6xIRJskvyTotX_6gVzq8g>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jan 2023 20:27:58 -0500 (EST)
Message-ID: <a2a8d8daac892e2d7eb8cffecfa1a20cdc9b0faa.camel@russell.cc>
Subject: Re: [PATCH v2 7/7] powerpc/pseries: Implement secvars for dynamic
 secure boot
From:   Russell Currey <ruscur@russell.cc>
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        zohar@linux.ibm.com
Date:   Tue, 10 Jan 2023 12:27:55 +1100
In-Reply-To: <cca49d1e5da01e9ccdee50d710045fd09005459c.camel@linux.ibm.com>
References: <20221230042014.154483-1-ruscur@russell.cc>
         <20221230042014.154483-8-ruscur@russell.cc>
         <87zgawgcpa.fsf@mpe.ellerman.id.au>
         <b4b23fb8a56fdcfffe28c38ac3f4f89e0c488486.camel@russell.cc>
         <cca49d1e5da01e9ccdee50d710045fd09005459c.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-09 at 16:20 +1100, Andrew Donnellan wrote:
> On Mon, 2023-01-09 at 14:34 +1100, Russell Currey wrote:
> >=20
> > > > +static int plpks_secvar_init(void)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!plpks_is_available(=
))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0set_secvar_ops(&plpks_se=
cvar_ops);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0set_secvar_config_attrs(=
config_attrs);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > +}
> > > > +device_initcall(plpks_secvar_init);
> > >=20
> > > That must be a machine_device_initcall(pseries, ...), otherwise
> > > we
> > > will
> > > blow up doing a hcall on powernv in plpks_is_available().
> >=20
> > OK, can do.=C2=A0 I don't understand your case of how powernv could hit
> > this, but I think I to have to move plpks_is_available() into
> > include/,
> > so it's going to be even more possible anyway.
>=20
> Kernels can be compiled with both pseries and powernv support, in
> which
> case plpks_secvar_init() will be called unconditionally even when
> booting on a powernv machine.
>=20
> I can confirm that as it is, booting this on powernv qemu causes a
> panic.

Of course, I'm not sure why I thought an initcall in a platform that
wasn't active would magically not run on other platforms.

>=20

