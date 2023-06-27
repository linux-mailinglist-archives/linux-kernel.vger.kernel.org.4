Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F398773FF2F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjF0PCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjF0PBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:01:54 -0400
Received: from sonic309-26.consmr.mail.ne1.yahoo.com (sonic309-26.consmr.mail.ne1.yahoo.com [66.163.184.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B341991
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1687878112; bh=0wQW92aBn4Q9AlflvtKChiLu5LDrqG5d2oWf83D3xo8=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=SM7A1j0xIGWSdZopyZQrNvj9+vTzjIXUDof2SpOHB+zJ7bHUuzB6lc39Ok70zqk/D23/1OiHOCZDq9xvuux9PIVpiKXDPhNYgIdXk9FgFZuZrO0A/HIeNMLMKRrQUjEoquA69anGSMtN8csQxR08M0KzyZoAfAHrUjkebpRQwL5BWUCQxJbKEHLAAYMOX/SfF5HBvmPRnQG+mVGqKTn/JaWA275ka8R2iBzyA17RasvfQMNkDPMu+0mCRr56rNf7dXS3AHarT/uFqkctVhhh9K6xCXi9A42MkW6Nxuh6bqK96eC5ZS0gZWKSMVkHh1FyhydVbP8TPfax2yx+n7KvLg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1687878112; bh=CJU03iMc3QL4K5Vkypa36galTOe2yr32vKH8Xxp4ZF9=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=tt2WXj+2hcaGA+uAXSNUywoBwYLIe3kndmID+E3xznMph7TTZYKMOuXBbh/wyvSWrG75kDL8Z05m0cFlStijojESSHmBxTjJbdwYR/nSC/XmEO43nOmuDJj8+l1dnh21eH+/C/6gGXq4cvGfastaoe3vLexGRj4FAYg3SvJwZjiyLGeq3UW0GI8MKs6FNyCZpY4KhW+sYzwXp6T4ocaKyk12zjnBSGux92Ia/YtRZgwZySdp3a7/1T4PNk+RrhxBl2GSFgNLLG//7tnWY9sIJH5MZJU3BL9jp5e13xHlE2HZnBZmS2rTym4bn2ownf8Qfm5yGXfE1kHnFu6QYDsJww==
X-YMail-OSG: 1uM7e7IVM1ltyDakbVBwKiR2_UapmpeQMYH_TCtYehHAFI3Zp1CfBYzHsrQReqo
 XI0Wtx5uZ.8OdvxN0.1woBaYiu66cPAGUA68qEoY1oansQ9ZK2k9hGw3Bj802WtB93osYYlnQI.I
 llU5_5FHNb6jwL9qF9taBQpU2pIiW5pWRKMO64ZtdRkmF_TbyCI2uI_LUzXCHl4oDQWykPAood4f
 Xl3q81s3Mhww4tlo99jexQj2eQ5L2gDwCnCFXOE.ZwGfcwqs7fuebrcnhHqpLSPzZKNjWmm8b9UY
 1HxgvB9YB5oOgqUuKsAZ1uq4pRrhcLLdyWfFJkFaZT2B54eonKmyg_G2u4NwuohQOC9_rUXmFkeY
 Yk6ff7sJX0L4Nj9R3LNnEsp.CjIypGlSk65di.aT_RFHIH03HXbTr0YLlYmguAsVgHpyPWb750oA
 Ii01kujpROX9ybVDfQ4EAtQRrQY3hFe_Cb5KmoR7plPG2ZcXaI73XRaUJBifekHqbr75sveJ.rAa
 .5K2hjC2VCh21KgFDYCcW.cLuBKd8PiA48nL4Nu26yYUJTTXSjMau45xFx6X_8fsDrIEMxrSa89a
 gqpu8kJzGRPFJvjRlk70J3KjIZDGdZfiWRnn79_mw13g.BVV9knVVqsyFO6pdsS8HNvXNpTkqi_S
 d4bh8AsqKUmZSDL9.rESM0UkB7XroLYsFkBQOBDFgac8uOhLMDm1yIC7bjocDWUeqiAV9bLSFZbN
 pNDFcvNo6mEHzbQhodsf2KTwrxgXK7pa3ouVsPuayLc0ekyYsm_U_yvStofaDSLVEy4.gYY0tbA6
 msNnS46wXJUIYG1nYSBPN3uljBvVRgApViwnFd8EbpDK0BGknOVYp5ss1BBh9KJMsd9LrsjlwF1P
 AW8GplYSmBlJPo4PEsM2TFDJFUQomqG2WkeBu3rpUs0cQkiDFY.YZPtctdfoNvDHdrP3.RzZeVuX
 abhnPAU1BT2nrSwFgsRaSLFFoJz3RtemdyghTJspgz4HJPIQIA74xS_ktFRPPVhUuTPZgvy0U641
 Xj34Qu1dvP1dpozbq_UXs3VE.7ovo4vcpJhwYjwlf7nSMNjVCbsJ.PcRACyuNWxA_YFbjF4U3Kjd
 NPHAfCYx3tdrOb3H051jIfmmVb7Tc5.CBMt6zuaaXKcXUbO6ktn7HREvIc.0fRb9NaqTatnCeJPE
 0AjeHuVkqaU0J3Hhlg68Pvz90iRAQj3KJ_Mt_oYrTZbjUQRXsknLxr3BtFj9c5BLW08whxcrMDfu
 ohGPZvN3piLzy6dBe7QW_RxgGXMi2TK48b8QaZxryFmukzRL5uPkSyzwfyCmDe6iWk8YgWvIMyzh
 C35sTq9YXd3sN3z_vJzTFPHgdtlwAc1AbrFC2xpRblGbUDd.cDlcVLetr7X549cLSD9b944kh7tB
 Fyib6g7eaF.PrJt8NZiFuJ8fAvkA0UjUG95hUA7EdyHHNFrap1F3TUBApUfUEF73Huz0UEzBHck8
 hJRYkbeNm6VHC3xBdGiYkYb9TTQUpaiJYm1twZrdqt9Bwu6874krnQ91vQuf4zpIpJ3aLyNZ2MoQ
 CCrtacnjnl7EY1QubNMc0nwe.PbF7gTFvHi5lay1VRj1edI75BSE45wRYKG_M0zxLQyNIpb1K_aY
 OGhF8jkBaRdw9aZwAO6E2qHjoXdEnUjH8R6iDT9RwVGU6jPtReEYymANmkL0V8rAg5pEcMlpWdkA
 cTkocXsQidNPAzFoXuqDJkQC5yvlkp7d5ci_ItnPR62s9eBk.6dFJQajyj7ikgx5.obf_WRmjgEn
 UR9Kt1863ZPbR9EHJAcHxDVdBbS9AfiV5JaohT2zhU8zjQ5cxMlY_H0Q3tABNAA2QnBojfTCSgIT
 gbf4fX6UHhK8VQlLeKWIR5pEdprtJQ_ZXmincwu0_p7nfEJ1WsziEp6oXgvrRbUm0GQrVwyiy7lw
 dvd9xO.7.qO5Cxf5RcWY8ob78sYTa4oiPQkAyZ1HPtnNVgN2iKxou9kFdB7Av0zk4pQj6oEOpG0Y
 tKfPqeto9u08OT4JodA_rIPfWaBVDLbS52dHiV9vegQc.MxRhE_GMEz1MNwI6ZfRMuiRrZxZz1NE
 rlfDdJ.9xF72rz_AfMGda5.TnIBwflqA_HjQuafvvpHYFIlWWKTZgNFRPVEqC1bNxqZsWX5zf2V2
 qK2qUXRnk_1r6YtcvVWJWg0q31sk4f8l7W9Mvq408IBWD0ug5Va23bgZzkR16hYxs9O_mm4bIbQB
 zniRVWAkq1ZUkt13pO1ZvU3Kx6DYHsrWb4.2Flp.wKYlc1h3YWL7A78.fDyOHJ8gSOKYW
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9bcb62f4-e2ec-4f03-864e-8043eb9c62f5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Jun 2023 15:01:52 +0000
Received: by hermes--production-bf1-54475bbfff-gh86g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7943ef10e253e9d3bdc38850640bba40;
          Tue, 27 Jun 2023 15:01:47 +0000 (UTC)
Message-ID: <3b1107c2-77c1-28ce-3413-bec589eae083@schaufler-ca.com>
Date:   Tue, 27 Jun 2023 08:01:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for 6.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <3b1107c2-77c1-28ce-3413-bec589eae083.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.21557 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the Smack pull request for v6.5.

There are two patches, both of which change how Smack initializes
the SMACK64TRANSMUTE extended attribute. The first corrects the
behavior of overlayfs, which creates inodes differently from other
filesystems. The second ensures that transmute attributes specified
by mount options are correctly assigned. These updates have been in
the next branch and pass all tests. Thank you.

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-6.5

for you to fetch changes up to 2c085f3a8f23c9b444e8b99d93c15d7ce870fc4e:

  smack: Record transmuting in smk_transmuted (2023-05-11 10:05:39 -0700)

----------------------------------------------------------------
Two patches that improve inode attribute initialization.

----------------------------------------------------------------
Roberto Sassu (2):
      smack: Retrieve transmuting information in smack_inode_getsecurity()
      smack: Record transmuting in smk_transmuted

 security/smack/smack.h     |  1 +
 security/smack/smack_lsm.c | 63 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 48 insertions(+), 16 deletions(-)

