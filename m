Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804915B9A49
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiIOMDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIOMDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:03:35 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92655282C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:03:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 107215808F5;
        Thu, 15 Sep 2022 08:03:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 15 Sep 2022 08:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1663243414; x=
        1663247014; bh=fFR/6Ar4G2O+sqOdkpiYHA6NikOY7dLAioUUv6WpXYA=; b=B
        PD6a8fMDM8bYERbVLd/e7Fx2hBE+A+oEfSy3hWkxW6mOxOA/PfuYUSgwth1PEzap
        u2SXu7XEoLn9GPlRmrihkm7BLSI6+Db//f7RbW5P/WMQcnBy6ZrAmLMOTrqii/6e
        Vnip0UGljXQtDtQosVYBbPmdtVnFXbubcQoZ8LBe1kBkQPaOListrKWLn2AwvUZ9
        4XDFQGJZaReOiIHGziCgV49hBL0AcHzVay1iiNPLzGesYXa9ydjSYhwhSm0mBqcL
        OTI1efZ+0q0JPBFa2bKqlEPkTZYa/jmvesbsBHJ1DOPZJTtOo7AWPDFoehvZh8BZ
        uiYDEWaWrNJgdnlTMCAGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663243414; x=
        1663247014; bh=fFR/6Ar4G2O+sqOdkpiYHA6NikOY7dLAioUUv6WpXYA=; b=F
        BLSBvdFl9mJMVQbMb6+2O/unWNi6SdijlwngfkDipavEO3E0VW3KQOAp71DoWLWL
        HzzIbJ92m3qF2/PsP0Fopppd475c2opaOkb11ciJyYYMvOqXo3E/650csbsOyWoH
        maDmUHpxG3YP2iKvoIGiCRTo3mboCADQHdpnc/38BdX0/snHanUIJHu83hxLuCyC
        v5mRTLcpcpUtt6JTUNSHwF+VGUHPQma8qiZeJbmXLUkAkpvgSkno3gLcRDQw/hwv
        UaxAn1RH7jxFWHjTeKGRiK0Y/+PP5hjHAu6M1BeXi9ul0PijFHGyxEuUjv5S0GjO
        LYrxTcGC29vBthj7zchYQ==
X-ME-Sender: <xms:lRQjY98jQgiUG1JR5EA2GzZFIY38SMbqmuUucz-alOjHSstpRGVeWg>
    <xme:lRQjYxu87atIyg4VdHBPvjooJI_k113takEibki92l_zN0iQ4aYuJZs_8iEnHkau6
    GFhjF-koAM7TTonQps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedukedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:lRQjY7CxfZXIKkiQ5lG-5RrMwk-zLpfIEvu6ZiGZkCpn9d4mfaUxwQ>
    <xmx:lRQjYxc0TEcTQ1aG28gi63IpXT3DeBZIClCmDosly-XjvgpBdk44yg>
    <xmx:lRQjYyOctgWgWGXqV7aR-Bsw2cIGjBEWyb6ZKfWf085S0mRPVCZIlw>
    <xmx:lRQjYxeDetGhxQxK_f76RpP1ewPxDSFcFfsGJg9Vhpe1J0NV5JjcaA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5090BB60086; Thu, 15 Sep 2022 08:03:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <a7328d95-e487-42ac-8fa8-9662911957e5@www.fastmail.com>
In-Reply-To: <YyLrwW0qHpgxq4MK@kadam>
References: <YyEQr//Iq7bautrm@dev-arch.thelio-3990X>
 <20220914211057.423617-1-nhuck@google.com>
 <b66ea89d-c62e-4772-b3d7-6e236da837af@www.fastmail.com>
 <YyLrwW0qHpgxq4MK@kadam>
Date:   Thu, 15 Sep 2022 14:03:12 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dan Carpenter" <dan.carpenter@oracle.com>
Cc:     "Nathan Huckleberry" <nhuck@google.com>, nathan@kernel.org,
        error27@gmail.com,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        llvm@lists.linux.dev, "Nick Desaulniers" <ndesaulniers@google.com>,
        trix@redhat.com
Subject: Re: [PATCH v3] staging: octeon: Fix return type of cvm_oct_xmit and
 cvm_oct_xmit_pow
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022, at 11:09 AM, Dan Carpenter wrote:
> On Thu, Sep 15, 2022 at 10:21:47AM +0200, Arnd Bergmann wrote:
>> On Wed, Sep 14, 2022, at 11:10 PM, Nathan Huckleberry wrote:
> > - This has probably been discussed before, but why is this only
> >   reported by smatch but by clang itself when building with CFI
> >   enabled? It appears that CFI enforces stricter C++ style type
> >   compatibility on enums while the warnings only catch incompatible
> >   types according to the normal C11 rules.
>
> This is not in a released version of Smatch.  I wrote the check and
> attached it to the email with the bug reports but I wasn't really sure
> how enums are handled in Clang. It's a gray area in the C standard.
>
> I'll release it now since no one complained about false positives, but
> yes, ideally this would be built into the compiler.

I think there are two separate issues here:

- clang-cfi being inconsistent regarding which types it considers
  compatible, compared to what code it otherwise sees as valid.

- generally warning about valid conversions between integer pointers
  and pointers to compatible enums, along the lines of -Wpointer-sign
  and -Wenum-enum-conversion.

> GCC does some sort of surprising things with enums and the kernel reli=
es
> on it in various places.  By default enums in GCC are unsigned int.  If
> they have to store values which don't fit into unsigned int (negatives
> or larger than UINT_MAX) type is adjusted to be signed or a larger typ=
e.

Isn't this defined in the ELF psABI for a given architecture, rather
than compiler specific or in the C standard? E.g. the Arm AAPCS
document lists

8.1.3 Enumerated Types
This ABI delegates a choice of representation of enumerated types to
a platform ABI (whether defined by a standardor by custom and practice)
or to an interface contract if there is no defined platform ABI.
The two permitted ABI variants are:
=E2=80=A2 An enumerated type normally occupies a word (int or unsigned i=
nt).
  If a word cannot represent all of its enumerated values the type
  occupies a double word (long long or unsigned long long).
=E2=80=A2 The type of the storage container for an enumerated type is the
  smallest integer type that can contain all of its enumerated=20
  values. When both the signed and unsigned versions of an integer
  type can represent all values, this ABI recommends that the
  unsigned type should be preferred (in line with common practice).

> Also if the enum is in a struct and the type can be made smaller then
> GCC will.  And example of this is in union myrs_cmd_mbox where the
> enum myrs_cmd_opcode opcode only takes one byte. The SCSI_MYRB driver
> relies on the struct thing and will corrupt memory if the struct is
> larger than expected.  This is the only example I know of in the kernel
> where this matters.

Ah, interesting, I had no idea. Experimenting with it a bit
showed this to be independent of being in a struct, and only
a feature of GCC's "packed" attribute. E.g. this line creates
a zero-initialized single byte variable and an overflow warning:

enum { A } __attribute__((packed)) e =3D 256;

There is also a type mismatch warning with both gcc and clang
when trying to use function types that differ in the size or
signedness of an enum:

typedef enum { A } __attribute__((packed)) byteenum;
extern unsigned int f(void);
byteenum (*fp)(void) =3D f;

For the case of netdev_tx_t, we can actually take advantage of this
with a patch to make it an incompatible length to create a compiler
warning. See patch and output below.

    Arnd

--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -117,12 +117,11 @@ void netdev_set_default_ethtool_ops(struct net_dev=
ice *dev,
 /* Driver transmit return codes */
 #define NETDEV_TX_MASK         0xf0
=20
-enum netdev_tx {
-       __NETDEV_TX_MIN  =3D INT_MIN,     /* make sure enum is signed */
+typedef enum {
+       __NETDEV_TX_MIN  =3D S8_MIN,      /* make sure enum is signed */
        NETDEV_TX_OK     =3D 0x00,        /* driver took care of packet =
*/
        NETDEV_TX_BUSY   =3D 0x10,        /* driver tx path was busy*/
-};
-typedef enum netdev_tx netdev_tx_t;
+} __packed netdev_tx_t;
=20
 /*
  * Current order:

ethernet/broadcom/bcm4908_enet.c:677:27: error: initialization of 'netde=
v_tx_t (*)(struct sk_buff *, struct net_device *)' from incompatible poi=
nter type 'int (*)(struct sk_buff *, struct net_device *)' [-Werror=3Din=
compatible-pointer-types]
bond_alb.h:160:5: note: previous declaration of 'bond_tlb_xmit' with typ=
e 'int(struct sk_buff *, struct net_device *)'
bond_alb.h:159:5: note: previous declaration of 'bond_alb_xmit' with typ=
e 'int(struct sk_buff *, struct net_device *)'
ethernet/litex/litex_liteeth.c:199:35: error: initialization of 'netdev_=
tx_t (*)(struct sk_buff *, struct net_device *)' from incompatible point=
er type 'int (*)(struct sk_buff *, struct net_device *)' [-Werror=3Dinco=
mpatible-pointer-types]
hamradio/baycom_epp.c:1119:32: error: initialization of 'netdev_tx_t (*)=
(struct sk_buff *, struct net_device *)' from incompatible pointer type =
'int (*)(struct sk_buff *, struct net_device *)' [-Werror=3Dincompatible=
-pointer-types]
ethernet/asix/ax88796c_main.c:937:35: error: initialization of 'netdev_t=
x_t (*)(struct sk_buff *, struct net_device *)' from incompatible pointe=
r type 'int (*)(struct sk_buff *, struct net_device *)' [-Werror=3Dincom=
patible-pointer-types]
wwan/t7xx/t7xx_netdev.c:111:29: error: initialization of 'netdev_tx_t (*=
)(struct sk_buff *, struct net_device *)' from incompatible pointer type=
 'int (*)(struct sk_buff *, struct net_device *)' [-Werror=3Dincompatibl=
e-pointer-types]
ethernet/microchip/sparx5/sparx5_netdev.c:223:35: error: initialization =
of 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' from incompa=
tible pointer type 'int (*)(struct sk_buff *, struct net_device *)' [-We=
rror=3Dincompatible-pointer-types]
ethernet/sunplus/spl2sw_driver.c:198:27: error: initialization of 'netde=
v_tx_t (*)(struct sk_buff *, struct net_device *)' from incompatible poi=
nter type 'int (*)(struct sk_buff *, struct net_device *)' [-Werror=3Din=
compatible-pointer-types]
ethernet/korina.c:1272:35: error: initialization of 'netdev_tx_t (*)(str=
uct sk_buff *, struct net_device *)' from incompatible pointer type 'int=
 (*)(struct sk_buff *, struct net_device *)' [-Werror=3Dincompatible-poi=
nter-types]
ethernet/sfc/ef100_tx.h:25:13: note: previous declaration of 'ef100_enqu=
eue_skb' with type 'netdev_tx_t(struct efx_tx_queue *, struct sk_buff *)'
ethernet/microchip/lan966x/lan966x_main.c:461:43: error: initialization =
of 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' from incompa=
tible pointer type 'int (*)(struct sk_buff *, struct net_device *)' [-We=
rror=3Dincompatible-pointer-types]
ethernet/ti/davinci_emac.c:1718:35: error: initialization of 'netdev_tx_=
t (*)(struct sk_buff *, struct net_device *)' from incompatible pointer =
type 'int (*)(struct sk_buff *, struct net_device *)' [-Werror=3Dincompa=
tible-pointer-types]
ethernet/davicom/dm9000.c:1372:35: error: initialization of 'netdev_tx_t=
 (*)(struct sk_buff *, struct net_device *)' from incompatible pointer t=
ype 'int (*)(struct sk_buff *, struct net_device *)' [-Werror=3Dincompat=
ible-pointer-types]
ethernet/ti/netcp_core.c:1944:35: error: initialization of 'netdev_tx_t =
(*)(struct sk_buff *, struct net_device *)' from incompatible pointer ty=
pe 'int (*)(struct sk_buff *, struct net_device *)' [-Werror=3Dincompati=
ble-pointer-types]
